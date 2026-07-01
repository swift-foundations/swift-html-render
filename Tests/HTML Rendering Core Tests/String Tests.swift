//
//  String Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

@_spi(DynamicHTML) import HTML_Rendering_Core
import HTML_Rendering
import HTML_Standard
import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

@Suite
struct `String Extensions Tests` {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `String Extensions Tests`.Unit {

    @Test
    func `String from HTML text`() throws {
        let text = HTML.Text("simple text")
        let string = try String(text)
        #expect(string == "simple text")
    }

    @Test
    func `String conversion does not throw`() throws {
        let element = tag("div") {
            HTML.Text("content")
        }

        let result = try String(element)
        #expect(result.contains("content"))
    }
}

// MARK: - EdgeCase

extension `String Extensions Tests`.EdgeCase {

    @Test
    func `String from empty HTML`() throws {
        let empty = HTML.Empty()
        let string = try String(empty)
        #expect(string.isEmpty)
    }
}

// MARK: - Integration

extension `String Extensions Tests`.Integration {

    @Test
    func `String from HTML element`() throws {
        let element = tag("div") {
            HTML.Text("test content")
        }

        let string = try String(HTML.Document { element })
        #expect(string.contains("<div>"))
        #expect(string.contains("test content"))
        #expect(string.contains("</div>"))
    }

    @Test
    func `String from complex HTML structure`() throws {
        let html = tag("article") {
            tag("header") {
                tag("h1") {
                    HTML.Text("Article Title")
                }
            }
            tag("section") {
                tag("p") {
                    HTML.Text("Paragraph content")
                }
            }
        }

        let string = try String(HTML.Document { html })
        #expect(string.contains("<article>"))
        #expect(string.contains("<h1>Article Title</h1>"))
        #expect(string.contains("<p>Paragraph content</p>"))
        #expect(string.contains("</article>"))
    }

    @Test
    func `String from HTML with attributes`() throws {
        let element = tag("div") {
            HTML.Text("content")
        }
        .attribute("class", "test-class")
        .attribute("id", "test-id")

        let string = try String(HTML.Document { element })
        #expect(string.contains("class=\"test-class\""))
        #expect(string.contains("id=\"test-id\""))
        #expect(string.contains("content"))
    }
}
