//
//  Rendering Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//
//  Tests for HTML rendering functionality (formerly HTMLPrinter).
//

import Foundation
@_spi(DynamicHTML) import HTML_Rendering_Core
import HTML_Rendering
import HTML_Standard
import ASCII
import Render_Primitives
import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

@Suite
struct `Rendering Tests` {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
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
}

// MARK: - EdgeCase

extension `Rendering Tests`.EdgeCase {

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
