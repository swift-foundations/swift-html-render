//
//  HTMLStyled Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

@_spi(DynamicHTML) import HTML_Rendering_Core
import HTML_Rendering
import HTML_Standard
import Testing

// HTML.Styled is generic — use parallel namespace pattern [TEST-004].

// MARK: - Test Suite

@Suite("HTML.Styled")
struct HTMLStyledTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension HTMLStyledTests.Unit {

    @Test
    func `inlineStyle creates styled element`() throws {
        let html = tag("div") {
            HTML.Text("Styled content")
        }
        .inlineStyle("color", "red")

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("color:red"))
    }

    @Test
    func `multiple styles are applied`() throws {
        let html = tag("div") {
            HTML.Text("Content")
        }
        .inlineStyle("color", "red")
        .inlineStyle("margin", "10px")
        .inlineStyle("padding", "5px")

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("color:red"))
        #expect(rendered.contains("margin:10px"))
        #expect(rendered.contains("padding:5px"))
    }

    @Test
    func `content is preserved through styling`() throws {
        let html = tag("span") {
            HTML.Text("Original content")
        }
        .inlineStyle("font-weight", "bold")

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("Original content"))
        #expect(rendered.contains("<span"))
    }

    @Test
    func `nested content preserved`() throws {
        let html = tag("div") {
            tag("p") {
                HTML.Text("Paragraph")
            }
        }
        .inlineStyle("background", "white")

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("<div"))
        #expect(rendered.contains("<p>"))
        #expect(rendered.contains("Paragraph"))
    }

    @Test
    func `chained styles all apply`() throws {
        let html = tag("div") {
            HTML.Text("Multi-styled")
        }
        .inlineStyle("color", "blue")
        .inlineStyle("background-color", "yellow")
        .inlineStyle("border", "1px solid black")

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("color:blue"))
        #expect(rendered.contains("background-color:yellow"))
        #expect(rendered.contains("border:1px solid black"))
    }

    @Test
    func `style with media query`() throws {
        let html = tag("div") {
            HTML.Text("Responsive")
        }
        .inlineStyle(
            "display",
            "none",
            atRule: .init(rawValue: "@media print"),
            selector: nil,
            pseudo: nil
        )

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("@media print"))
        #expect(rendered.contains("display:none"))
    }

    @Test
    func `multiple media queries`() throws {
        let html = tag("div") {
            HTML.Text("Content")
        }
        .inlineStyle(
            "width",
            "100%",
            atRule: .init(rawValue: "@media (max-width: 768px)"),
            selector: nil,
            pseudo: nil
        )
        .inlineStyle(
            "width",
            "50%",
            atRule: .init(rawValue: "@media (min-width: 769px)"),
            selector: nil,
            pseudo: nil
        )

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("@media (max-width: 768px)"))
        #expect(rendered.contains("@media (min-width: 769px)"))
    }

    @Test
    func `style with pseudo class`() throws {
        let html = tag("a") {
            HTML.Text("Hover me")
        }
        .attribute("href", "#")
        .inlineStyle("color", "red", pseudo: .hover)

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains(":hover"))
        #expect(rendered.contains("color:red"))
    }

    @Test
    func `style preserved through type erasure`() throws {
        let original = tag("div") {
            HTML.Text("Erased")
        }
        .inlineStyle("color", "green")

        let erased: HTML.AnyView = .init(original)
        let rendered = try String(HTML.Document { erased })

        #expect(rendered.contains("color:green"))
        #expect(rendered.contains("Erased"))
    }
}

// MARK: - EdgeCase

extension HTMLStyledTests.EdgeCase {

    @Test
    func `empty style value`() throws {
        let html = tag("div") {
            HTML.Text("Content")
        }
        .inlineStyle("color", "")

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("<div"))
    }
}

// MARK: - Integration

extension HTMLStyledTests.Integration {

    @Test
    func `conditional content with styles`() throws {
        let showFirst = true
        let html = HTML.Group {
            if showFirst {
                tag("div") {
                    HTML.Text("First")
                }
                .inlineStyle("color", "red")
            } else {
                tag("div") {
                    HTML.Text("Second")
                }
                .inlineStyle("color", "blue")
            }
        }

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("color:red"))
        #expect(!rendered.contains("color:blue"))
    }

    @Test
    func `array of styled elements`() throws {
        let colors = ["red", "green", "blue"]
        let html = HTML.Group {
            for color in colors {
                tag("span") {
                    HTML.Text(color)
                }
                .inlineStyle("color", color)
            }
        }

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("color:red"))
        #expect(rendered.contains("color:green"))
        #expect(rendered.contains("color:blue"))
    }
}
