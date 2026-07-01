//
//  Never Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import HTML_Rendering_Core
import Testing

@testable import HTML_Rendering_Core

// Never is a stdlib type — use manual @Suite pattern [TEST-004].

// MARK: - Test Suite

@Suite("Never + HTML.View")
struct NeverHTMLTests {
    @Suite struct Unit {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension NeverHTMLTests.Unit {

    @Test
    func `conforms to HTML.View`() {
        func acceptsHTML<T: HTML.View>(_ type: T.Type) -> Bool {
            return true
        }

        #expect(acceptsHTML(Never.self))
    }

    @Test
    func `Never body allows custom rendering`() throws {
        struct CustomHTML: HTML.View {
            typealias Body = Never
            var body: Never { fatalError("body should not be called") }

            static func _render(
                _ view: borrowing Self, context: inout Render.Context
            ) {
                context.write(raw: Array("Custom".utf8))
            }
        }

        let rendered = try String(CustomHTML())
        #expect(rendered == "Custom")
    }

    @Test
    func `enables compile-time safety`() {
        func usesHTML<T: HTML.View>(_ html: T) -> String {
            return String(describing: type(of: html))
        }

        let text = HTML.Text("test")
        let empty = HTML.Empty()
        let raw = HTML.Raw("raw")

        #expect(usesHTML(text) == "Text")
        #expect(usesHTML(empty) == "Empty")
        #expect(usesHTML(raw) == "Raw")
    }
}

// MARK: - Integration

extension NeverHTMLTests.Integration {

    @Test
    func `HTML.Text body is Never`() throws {
        let text = HTML.Text("Direct render")
        let rendered = try String(text)
        #expect(rendered == "Direct render")
    }

    @Test
    func `HTML.Empty body is Never`() throws {
        let empty = HTML.Empty()
        let rendered = try String(empty)
        #expect(rendered.isEmpty)
    }

    @Test
    func `HTML.Raw body is Never`() throws {
        let raw = HTML.Raw("<b>Bold</b>")
        let rendered = try String(raw)
        #expect(rendered == "<b>Bold</b>")
    }
}
