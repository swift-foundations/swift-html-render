//
//  HTML.Text Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `HTML.Text Tests` {

    // MARK: - Initialization

    @Test
    func `HTML.Text basic initialization`() throws {
        let text = HTML.Text("Hello, World!")
        let rendered = try String(text)
        #expect(rendered == "Hello, World!")
    }

    @Test
    func `HTML.Text empty string`() throws {
        let text = HTML.Text("")
        let rendered = try String(text)
        #expect(rendered.isEmpty)
    }

    @Test
    func `HTML.Text string literal initialization`() throws {
        let text: HTML.Text = "Hello from literal"
        let rendered = try String(text)
        #expect(rendered == "Hello from literal")
    }

    @Test
    func `HTML.Text string interpolation`() throws {
        let name = "World"
        let text: HTML.Text = "Hello, \(name)!"
        let rendered = try String(text)
        #expect(rendered == "Hello, World!")
    }

    // MARK: - HTML Escaping

    @Test
    func `HTML.Text escapes ampersand`() throws {
        let text = HTML.Text("Rock & Roll")
        let rendered = try String(text)
        #expect(rendered == "Rock &amp; Roll")
    }

    @Test
    func `HTML.Text escapes less than`() throws {
        let text = HTML.Text("a < b")
        let rendered = try String(text)
        #expect(rendered == "a &lt; b")
    }

    @Test
    func `HTML.Text escapes greater than`() throws {
        let text = HTML.Text("a > b")
        let rendered = try String(text)
        #expect(rendered == "a &gt; b")
    }

    @Test
    func `HTML.Text escapes multiple special characters`() throws {
        let text = HTML.Text("<script>alert('XSS');</script>")
        let rendered = try String(text)
        #expect(rendered == "&lt;script&gt;alert('XSS');&lt;/script&gt;")
    }

    @Test
    func `HTML.Text preserves quotes - not escaped in text content`() throws {
        let text = HTML.Text("He said \"Hello\"")
        let rendered = try String(text)
        #expect(rendered == "He said \"Hello\"")
    }

    @Test
    func `HTML.Text preserves single quotes`() throws {
        let text = HTML.Text("It's working")
        let rendered = try String(text)
        #expect(rendered == "It's working")
    }

    // MARK: - Concatenation

    @Test
    func `HTML.Text concatenation with + operator`() throws {
        let hello = HTML.Text("Hello, ")
        let world = HTML.Text("World!")
        let combined = hello + world
        let rendered = try String(combined)
        #expect(rendered == "Hello, World!")
    }

    @Test
    func `HTML.Text concatenation preserves escaping`() throws {
        let left = HTML.Text("A & B")
        let right = HTML.Text(" < C")
        let combined = left + right
        let rendered = try String(combined)
        #expect(rendered == "A &amp; B &lt; C")
    }

    // MARK: - Unicode

    @Test
    func `HTML.Text preserves Unicode characters`() throws {
        let text = HTML.Text("Hello, 世界! 🌍")
        let rendered = try String(text)
        #expect(rendered == "Hello, 世界! 🌍")
    }

    @Test
    func `HTML.Text preserves emoji`() throws {
        let text = HTML.Text("👍🏽 Great job!")
        let rendered = try String(text)
        #expect(rendered == "👍🏽 Great job!")
    }

    // MARK: - Edge Cases

    @Test
    func `HTML.Text with newlines`() throws {
        let text = HTML.Text("Line 1\nLine 2\nLine 3")
        let rendered = try String(text)
        #expect(rendered == "Line 1\nLine 2\nLine 3")
    }

    @Test
    func `HTML.Text with tabs`() throws {
        let text = HTML.Text("Col1\tCol2\tCol3")
        let rendered = try String(text)
        #expect(rendered == "Col1\tCol2\tCol3")
    }

    @Test
    func `HTML.Text in document context`() throws {
        let document = HTML.Document {
            tag("p") {
                HTML.Text("This is & that")
            }
        }
        let rendered = try String(document)
        #expect(rendered.contains("This is &amp; that"))
    }
}

// MARK: - Snapshot Tests

extension `Snapshot Tests` {
    @Suite
    struct HTMLTextSnapshotTests {
        @Test
        func `HTML.Text basic rendering snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        tag("h1") {
                            HTML.Text("Welcome & Hello")
                        }
                        tag("p") {
                            HTML.Text("This is a paragraph with <special> characters & symbols.")
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
                    <div>
                      <h1>Welcome &amp; Hello
                      </h1>
                      <p>This is a paragraph with &lt;special&gt; characters &amp; symbols.
                      </p>
                    </div>
                  </body>
                </html>
                """
            }
        }

        @Test
        func `HTML.Text with various content types snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("article") {
                        tag("h2") {
                            HTML.Text("Code Examples")
                        }
                        tag("p") {
                            HTML.Text("In HTML, use &lt;tag&gt; syntax (shown escaped).")
                        }
                        tag("p") {
                            HTML.Text("Copyright © 2025 - All rights reserved")
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
                      <h2>Code Examples
                      </h2>
                      <p>In HTML, use &amp;lt;tag&amp;gt; syntax (shown escaped).
                      </p>
                      <p>Copyright © 2025 - All rights reserved
                      </p>
                    </article>
                  </body>
                </html>
                """
            }
        }
    }
}
