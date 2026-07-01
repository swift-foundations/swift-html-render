//
//  AnyHTML Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `AnyHTML Tests` {

    // MARK: - Initialization

    @Test
    func `AnyHTML wraps HTML.Text`() throws {
        let text = HTML.Text("Hello")
        let anyHTML: HTML.AnyView = .init(text)
        let rendered = try String(anyHTML)
        #expect(rendered == "Hello")
    }

    @Test
    func `AnyHTML wraps HTML.Element`() throws {
        let element = tag("div") {
            HTML.Text("Content")
        }
        let anyHTML: HTML.AnyView = .init(element)
        let rendered = try String(anyHTML)
        #expect(rendered.contains("<div>"))
        #expect(rendered.contains("Content"))
        #expect(rendered.contains("</div>"))
    }

    @Test
    func `AnyHTML wraps Empty`() throws {
        let empty = HTML.Empty()
        let anyHTML: HTML.AnyView = .init(empty)
        let rendered = try String(anyHTML)
        #expect(rendered.isEmpty)
    }

    @Test
    func `AnyHTML closure initializer`() throws {
        let anyHTML = HTML.AnyView {
            tag("span") {
                HTML.Text("From closure")
            }
        }
        let rendered = try String(anyHTML)
        #expect(rendered.contains("<span>"))
        #expect(rendered.contains("From closure"))
    }

    // MARK: - Type Erasure

    @Test
    func `AnyHTML enables heterogeneous collections`() throws {
        let text = HTML.Text("Text")
        let div = tag("div") { HTML.Text("Div") }
        let span = tag("span") { HTML.Text("Span") }
        let elements: [HTML.AnyView] = [
            .init(text),
            .init(div),
            .init(span),
        ]

        let html = HTML.Group {
            for element in elements {
                element
            }
        }

        let rendered = try String(html)
        #expect(rendered.contains("Text"))
        #expect(rendered.contains("<div>"))
        #expect(rendered.contains("<span>"))
    }

    @Test
    func `AnyHTML preserves attributes`() throws {
        let element = tag("a") {
            HTML.Text("Link")
        }
        .attribute("href", "/page")
        .attribute("class", "nav-link")

        let anyHTML: HTML.AnyView = .init(element)
        let rendered = try String(HTML.Document { anyHTML })
        #expect(rendered.contains("href=\"/page\""))
        #expect(rendered.contains("class=\"nav-link\""))
    }

    @Test
    func `AnyHTML preserves styles`() throws {
        let element = tag("div") {
            HTML.Text("Styled")
        }
        .inlineStyle("color", "red")

        let anyHTML: HTML.AnyView = .init(element)
        let rendered = try String(HTML.Document { anyHTML })
        #expect(rendered.contains("color:red"))
    }

    // MARK: - Nested AnyHTML

    @Test
    func `AnyHTML can wrap AnyHTML`() throws {
        let text = HTML.Text("Inner")
        let inner: HTML.AnyView = .init(text)
        let outer: HTML.AnyView = .init(inner)
        let rendered = try String(outer)
        #expect(rendered == "Inner")
    }

    // MARK: - Complex Structures

    @Test
    func `AnyHTML with nested elements`() throws {
        let article = tag("article") {
            tag("h1") {
                HTML.Text("Title")
            }
            tag("p") {
                HTML.Text("Content")
            }
        }

        let anyHTML: HTML.AnyView = .init(article)
        let rendered = try String(anyHTML)
        #expect(rendered.contains("<article>"))
        #expect(rendered.contains("<h1>"))
        #expect(rendered.contains("<p>"))
    }

    // MARK: - Dynamic Content

    @Test
    func `AnyHTML for dynamic content selection`() throws {
        func createContent(type: String) -> HTML.AnyView {
            switch type {
            case "header":
                let h1 = tag("h1") { HTML.Text("Header") }
                return .init(h1)
            case "paragraph":
                let p = tag("p") { HTML.Text("Paragraph") }
                return .init(p)
            default:
                let text = HTML.Text("Default")
                return .init(text)
            }
        }

        let headerRendered = try String(createContent(type: "header"))
        let paragraphRendered = try String(createContent(type: "paragraph"))
        let defaultRendered = try String(createContent(type: "other"))

        #expect(headerRendered.contains("<h1>"))
        #expect(paragraphRendered.contains("<p>"))
        #expect(defaultRendered == "Default")
    }
}

// MARK: - Snapshot Tests

extension `Snapshot Tests` {
    @Suite
    struct AnyHTMLSnapshotTests {
        @Test
        func `AnyHTML type erasure snapshot`() {
            let h1 = tag("h1") { HTML.Text("Title") }
            let p1 = tag("p") { HTML.Text("First paragraph") }
            let p2 = tag("p") { HTML.Text("Second paragraph") }
            let elements: [HTML.AnyView] = [
                .init(h1),
                .init(p1),
                .init(p2),
            ]

            snapshot(as: .html) {
                HTML.Document {
                    tag("article") {
                        for element in elements {
                            element
                        }
                    }
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                  </head>
                  <body>
                    <article>
                      <h1>Title
                      </h1>
                      <p>First paragraph
                      </p>
                      <p>Second paragraph
                      </p>
                    </article>
                  </body>
                </html>
                """
            }
        }
    }
}
