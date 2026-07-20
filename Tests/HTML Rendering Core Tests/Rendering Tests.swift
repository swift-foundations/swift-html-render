//
//  Rendering Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//
//  Tests for HTML rendering functionality (formerly HTMLPrinter).
//

import ASCII
import Foundation
import HTML_Rendering
import HTML_Standard
import Render_Primitives
import Testing

@_spi(DynamicHTML) @testable import HTML_Rendering_Core

// MARK: - Test Suite

@Suite
struct `Rendering Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `Rendering Tests`.Unit {

    @Test
    func `basic rendering`() throws {
        let element = tag("div") {
            HTML.Text("test content")
        }

        try HTML.Context.Configuration.$current.withValue(.default) {
            let rendered = try String(element)

            #expect(rendered.contains("<div>"))
            #expect(rendered.contains("test content"))
            #expect(rendered.contains("</div>"))
        }
    }

    @Test
    func `rendering with pretty configuration`() throws {
        let element = tag("div") {
            HTML.Text("content")
        }

        try HTML.Context.Configuration.$current.withValue(.pretty) {
            let rendered = try String(element)

            #expect(!rendered.isEmpty)
            #expect(rendered.contains("content"))
            #expect(rendered.contains("\n"))
        }
    }

    @Test
    func `rendering configuration options`() throws {
        let defaultConfig = HTML.Context.Configuration.default
        let prettyConfig = HTML.Context.Configuration.pretty
        let emailConfig = HTML.Context.Configuration.email

        #expect(defaultConfig.indentation == [])
        #expect(defaultConfig.newline == [])
        #expect(!defaultConfig.forceImportant)

        #expect(prettyConfig.indentation == [.ascii.space, .ascii.space])
        #expect(prettyConfig.newline == [.ascii.lf])
        #expect(!prettyConfig.forceImportant)

        #expect(emailConfig.forceImportant)
    }

    @Test
    func `stylesheet generation via context`() throws {
        var context = HTML.Context(.pretty)

        let style = HTML.Element.Style(declaration: "color:red;font-size:16px")
        _ = context.pushStyle(style)

        let stylesheet = context.stylesheet
        #expect(stylesheet.contains("color:red"))
        #expect(stylesheet.contains("font-size:16px"))
    }

    /// F-102 regression (deterministic discriminator): `stylesheetBytes` groups
    /// styles by `atRule` before emission. Grouping through a plain `Dictionary`
    /// leaks that dictionary's per-instance, hash-seed-dependent iteration order
    /// into the emitted @media block order. This asserts the documented
    /// contract instead: the unscoped (nil-`atRule`) group first, then @media
    /// groups in first-registration order. Pre-fix this fails with probability
    /// 1 - 1/6! per process (six distinct @media groups registered below).
    @Test
    func `stylesheet emits at-rule groups in first-registration order`() {
        func registerAll(into context: inout HTML.Context) {
            _ = context.register(style: "color:#000", atRule: nil, selector: nil, pseudo: nil)
            _ = context.register(
                style: "color:#fff",
                atRule: "@media (prefers-color-scheme: dark)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "font-size:1rem",
                atRule: "@media only screen and (min-width: 768px) and (max-width: 1024px)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "font-size:2rem",
                atRule: "@media only screen and (min-width: 832px)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "font-size:3rem",
                atRule: "@media only screen and (max-width: 831px)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "font-size:4rem",
                atRule: "@media only screen and (min-width: 1200px)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "color:red",
                atRule: "@media print",
                selector: nil,
                pseudo: nil
            )
        }

        var context = HTML.Context()
        registerAll(into: &context)
        let sheet = context.stylesheet

        var order: [String] = []
        var searchStart = sheet.startIndex
        while let mediaRange = sheet[searchStart...].firstRange(of: "@media") {
            guard let braceIndex = sheet[mediaRange.lowerBound...].firstIndex(of: "{") else { break }
            order.append(String(sheet[mediaRange.lowerBound...braceIndex]))
            searchStart = sheet.index(after: braceIndex)
        }

        let expected = [
            "@media (prefers-color-scheme: dark){",
            "@media only screen and (min-width: 768px) and (max-width: 1024px){",
            "@media only screen and (min-width: 832px){",
            "@media only screen and (max-width: 831px){",
            "@media only screen and (min-width: 1200px){",
            "@media print{",
        ]
        #expect(order == expected, "media groups emitted in \(order) rather than registration order")
    }

    /// F-102 regression (consumer-level guarantee): rendering the same
    /// registrations many times, in fresh contexts, must produce
    /// byte-identical stylesheets every time — this is the property the
    /// RepoTraffic consumer repro actually depends on (hash-stable HTML across
    /// consecutive renders in the same server process). Paired with the
    /// registration-order assertion above rather than relied on alone: a
    /// Dictionary-backed grouping can be process-lucky and stay stable for many
    /// iterations before shuffling (observed empirically: 1 of 3 probe runs
    /// stayed stable across 200 in-process renders while the other 2 produced
    /// 5-6 distinct byte outputs).
    @Test
    func `repeated stylesheet renders are byte-identical across 200 iterations`() {
        func renderOnce() -> String {
            var context = HTML.Context()
            _ = context.register(style: "color:#000", atRule: nil, selector: nil, pseudo: nil)
            _ = context.register(
                style: "color:#fff",
                atRule: "@media (prefers-color-scheme: dark)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "font-size:1rem",
                atRule: "@media only screen and (min-width: 768px) and (max-width: 1024px)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "font-size:2rem",
                atRule: "@media only screen and (min-width: 832px)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "font-size:3rem",
                atRule: "@media only screen and (max-width: 831px)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "font-size:4rem",
                atRule: "@media only screen and (min-width: 1200px)",
                selector: nil,
                pseudo: nil
            )
            _ = context.register(
                style: "color:red",
                atRule: "@media print",
                selector: nil,
                pseudo: nil
            )
            return context.stylesheet
        }

        var distinct: Swift.Set<String> = []
        for _ in 0..<200 {
            distinct.insert(renderOnce())
        }
        #expect(distinct.count == 1, "in-process renders produced \(distinct.count) distinct outputs")
    }
}

// MARK: - EdgeCase

extension `Rendering Tests`.`Edge Case` {

    @Test
    func `empty content rendering`() throws {
        let empty = HTML.Empty()

        try HTML.Context.Configuration.$current.withValue(.default) {
            let rendered = try String(empty)

            #expect(rendered.isEmpty)
        }
    }
}

// MARK: - Integration

extension `Rendering Tests`.Integration {

    @Test
    func `nested elements rendering`() throws {
        let element = tag("div") {
            tag("p") {
                HTML.Text("nested content")
            }
        }

        HTML.Context.Configuration.$current.withValue(.default) {
            let bytes = ContiguousArray(element)
            let rendered = String(data: Data(bytes), encoding: .utf8) ?? ""

            #expect(rendered.contains("<div>"))
            #expect(rendered.contains("<p>"))
            #expect(rendered.contains("nested content"))
            #expect(rendered.contains("</p>"))
            #expect(rendered.contains("</div>"))
        }
    }

    @Test
    func `document rendering`() throws {
        let document = HTML.Document {
            tag("h1") {
                HTML.Text("Hello World")
            }
        } head: {
            tag("title") {
                HTML.Text("Test")
            }
        }

        try HTML.Context.Configuration.$current.withValue(.default) {
            let rendered = try String(document)

            #expect(rendered.contains("<!doctype html>"))
            #expect(rendered.contains("<title>Test</title>"))
            #expect(rendered.contains("<h1>Hello World</h1>"))
        }
    }
}
