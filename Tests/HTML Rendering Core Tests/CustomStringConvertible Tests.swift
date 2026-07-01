//
//  CustomStringConvertible Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

@_spi(DynamicHTML) import HTML_Rendering_Core
import HTML_Rendering
import HTML_Standard
import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

@Suite
struct `CustomStringConvertible Tests` {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `CustomStringConvertible Tests`.Unit {

    @Test
    func `HTML type with CustomStringConvertible has description`() {
        struct DescribableHTML: HTML.View, CustomStringConvertible {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text("Hello")
                }
            }
        }

        let html = DescribableHTML()
        let description = html.description

        #expect(description.contains("<div>"))
        #expect(description.contains("Hello"))
    }

    @Test
    func `description matches rendered bytes`() {
        struct TestHTML: HTML.View, CustomStringConvertible {
            var body: some HTML.View {
                tag("span") {
                    HTML.Text("Test content")
                }
            }
        }

        let html = TestHTML()
        let description = html.description
        let fromBytes = String(decoding: [UInt8](html), as: UTF8.self)

        #expect(description == fromBytes)
    }

    @Test
    func `can use in string interpolation`() {
        struct SimpleHTML: HTML.View, CustomStringConvertible {
            var body: some HTML.View {
                tag("b") {
                    HTML.Text("bold")
                }
            }
        }

        let html = SimpleHTML()
        let message = "The HTML is: \(html)"

        #expect(message.contains("<b>bold</b>"))
    }

    @Test
    func `can print to console`() {
        struct PrintableHTML: HTML.View, CustomStringConvertible {
            var body: some HTML.View {
                tag("p") {
                    HTML.Text("Printable")
                }
            }
        }

        let html = PrintableHTML()
        let output = String(describing: html)

        #expect(output.contains("<p>"))
        #expect(output.contains("Printable"))
    }

    @Test
    func `HTML without CustomStringConvertible uses default description`() {
        struct PlainHTML: HTML.View {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text("Plain")
                }
            }
        }

        let html = PlainHTML()
        let defaultDescription = String(describing: html)
        #expect(defaultDescription.contains("PlainHTML"))
    }
}

// MARK: - EdgeCase

extension `CustomStringConvertible Tests`.EdgeCase {

    @Test
    func `description with empty content`() {
        struct EmptyHTML: HTML.View, CustomStringConvertible {
            var body: some HTML.View {
                HTML.Empty()
            }
        }

        let html = EmptyHTML()
        #expect(html.description.isEmpty)
    }

    @Test
    func `description with Unicode content`() {
        struct UnicodeHTML: HTML.View, CustomStringConvertible {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text("H\u{00E9}llo W\u{00F6}rld \u{65E5}\u{672C}\u{8A9E}")
                }
            }
        }

        let html = UnicodeHTML()
        let description = html.description

        #expect(description.contains("H\u{00E9}llo"))
        #expect(description.contains("W\u{00F6}rld"))
        #expect(description.contains("\u{65E5}\u{672C}\u{8A9E}"))
    }

    @Test
    func `description escapes HTML entities`() {
        struct EscapingHTML: HTML.View, CustomStringConvertible {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text("<script>alert('XSS')</script>")
                }
            }
        }

        let html = EscapingHTML()
        let description = html.description

        #expect(description.contains("&lt;script&gt;"))
        #expect(!description.contains("<script>"))
    }
}

// MARK: - Integration

extension `CustomStringConvertible Tests`.Integration {

    @Test
    func `description with nested elements`() {
        struct NestedHTML: HTML.View, CustomStringConvertible {
            var body: some HTML.View {
                tag("ul") {
                    tag("li") { HTML.Text("Item 1") }
                    tag("li") { HTML.Text("Item 2") }
                }
            }
        }

        let html = NestedHTML()
        let description = html.description

        #expect(description.contains("<ul>"))
        #expect(description.contains("<li>"))
        #expect(description.contains("Item 1"))
        #expect(description.contains("Item 2"))
    }

    @Test
    func `description with attributes`() {
        struct AttributedHTML: HTML.View, CustomStringConvertible {
            var body: some HTML.View {
                tag("a") {
                    HTML.Text("Link")
                }
                .attribute("href", "https://example.com")
            }
        }

        let html = AttributedHTML()
        let description = html.description

        #expect(description.contains("href=\"https://example.com\""))
    }
}
