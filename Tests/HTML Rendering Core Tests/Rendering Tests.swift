import ASCII
import Foundation
import HTML_Rendering
import HTML_Standard
import Render_Primitives
import Testing

@_spi(DynamicHTML) @testable import HTML_Rendering_Core

@Suite
struct `Rendering Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

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

        let style = HTML.Style.Rule(declaration: "color:red;font-size:16px")
        _ = context.pushStyle(style)

        let stylesheet = context.stylesheet
        #expect(stylesheet.contains("color:red"))
        #expect(stylesheet.contains("font-size:16px"))
    }

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
            guard let braceIndex = sheet[mediaRange.lowerBound...].firstIndex(of: "{") else {
                break
            }
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
        #expect(
            order == expected,
            "media groups emitted in \(order) rather than registration order"
        )
    }

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
        #expect(
            distinct.count == 1,
            "in-process renders produced \(distinct.count) distinct outputs"
        )
    }
}

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
