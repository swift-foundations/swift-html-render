//
//  inlineStyle Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `inlineStyle Tests` {

    @Test
    func `Basic inline style`() throws {
        let styledElement = tag("div") {
            HTML.Text("styled content")
        }
        .inlineStyle("color", "red")

        let rendered = try String(HTML.Document { styledElement })
        #expect(rendered.contains("color:red"))
        #expect(rendered.contains("styled content"))
    }

    @Test
    func `Multiple inline styles`() throws {
        let styledElement = tag("div") {
            HTML.Text("content")
        }
        .inlineStyle("color", "red")
        .inlineStyle("background-color", "blue")
        .inlineStyle("font-size", "16px")

        let rendered = try String(HTML.Document { styledElement })
        #expect(rendered.contains("color:red"))
        #expect(rendered.contains("background-color:blue"))
        #expect(rendered.contains("font-size:16px"))
    }

    @Test
    func `Style chaining`() throws {
        let styledElement = tag("p") {
            HTML.Text("paragraph")
        }
        .inlineStyle("margin", "10px")
        .inlineStyle("padding", "5px")

        let rendered = try String(HTML.Document { styledElement })
        #expect(rendered.contains("margin:10px"))
        #expect(rendered.contains("padding:5px"))
    }

    @Test
    func `Style with attributes`() throws {
        let element = tag("div") {
            HTML.Text("content")
        }
        .attribute("class", "test-class")
        .inlineStyle("display", "flex")

        let rendered = try String(HTML.Document { element })
        #expect(rendered.contains("class=\"test-class\""))
        #expect(rendered.contains("display:flex"))
    }

    @Test
    func `Empty style value`() throws {
        let styledElement = tag("div") {
            HTML.Text("content")
        }
        .inlineStyle("color", "")

        let rendered = try String(HTML.Document { styledElement })
        // Empty values might be omitted or rendered as empty
        #expect(rendered.contains("content"))
    }
}

// MARK: - Snapshot Tests

extension `Snapshot Tests` {
    @Suite
    struct inlineStyleSnapshotTests {
        @Test
        func `Basic inline style snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        HTML.Text("Styled content")
                    }
                    .inlineStyle("color", "red")
                    .inlineStyle("font-size", "18px")
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                    <style>
                      .font-size-0{font-size:18px}
                      .color-1{color:red}
                    </style>
                  </head>
                  <body>
                    <div class="font-size-0 color-1">Styled content
                    </div>
                  </body>
                </html>
                """
            }
        }

        @Test
        func `Complex styling snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        tag("h1") {
                            HTML.Text("Welcome")
                        }
                        .inlineStyle("color", "navy")
                        .inlineStyle("font-family", "Arial, sans-serif")

                        tag("p") {
                            HTML.Text("This paragraph has styling.")
                        }
                        .inlineStyle("color", "#333")
                        .inlineStyle("padding", "10px")
                        .inlineStyle("background-color", "#f5f5f5")
                    }
                    .attribute("class", "container")
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                    <style>
                      .font-family-0{font-family:Arial, sans-serif}
                      .color-1{color:navy}
                      .background-color-2{background-color:#f5f5f5}
                      .padding-3{padding:10px}
                      .color-4{color:#333}
                    </style>
                  </head>
                  <body>
                    <div class="container">
                      <h1 class="font-family-0 color-1">Welcome
                      </h1>
                      <p class="background-color-2 padding-3 color-4">This paragraph has styling.
                      </p>
                    </div>
                  </body>
                </html>
                """
            }
        }

        @Test
        func `Style with attributes snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        tag("a") {
                            HTML.Text("Styled link")
                        }
                        .attribute("href", "https://example.com")
                        .inlineStyle("color", "#007bff")
                        .inlineStyle("text-decoration", "none")
                    }
                    .inlineStyle("padding", "20px")
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                    <style>
                      .padding-0{padding:20px}
                      .text-decoration-1{text-decoration:none}
                      .color-2{color:#007bff}
                    </style>
                  </head>
                  <body>
                    <div class="padding-0"><a class="text-decoration-1 color-2" href="https://example.com">Styled link</a>
                    </div>
                  </body>
                </html>
                """
            }
        }
    }
}
