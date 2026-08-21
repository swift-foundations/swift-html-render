import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `Edge Cases Tests` {

    @Test
    func `Empty HTML.Text renders nothing`() throws {
        let html = HTML.Text("")
        let rendered = try String(HTML.Group { html })
        #expect(rendered.isEmpty)
    }

    @Test
    func `Empty element renders open and close tags`() throws {
        let html = tag("div") { HTML.Empty() }
        let rendered = try String(html)
        #expect(rendered == "<div></div>")
    }

    @Test
    func `Nested empty elements`() throws {
        let html = tag("div") {
            tag("span") { HTML.Empty() }
            tag("p") { HTML.Empty() }
        }
        let rendered = try String(html)
        #expect(rendered.contains("<span></span>"))
        #expect(rendered.contains("<p></p>"))
    }

    @Test
    func `Whitespace-only text is preserved`() throws {
        let html = HTML.Text("   ")
        let rendered = try String(HTML.Group { html })
        #expect(rendered == "   ")
    }

    @Test
    func `Newlines in text are preserved`() throws {
        let html = HTML.Text("Line 1\nLine 2\nLine 3")
        let rendered = try String(HTML.Group { html })
        #expect(rendered.contains("\n"))
    }

    @Test
    func `Tabs in text are preserved`() throws {
        let html = HTML.Text("Column1\tColumn2\tColumn3")
        let rendered = try String(HTML.Group { html })
        #expect(rendered.contains("\t"))
    }

    @Test
    func `Very long text content`() throws {
        let longString = String(repeating: "a", count: 100_000)
        let html = tag("p") { HTML.Text(longString) }
        let rendered = try String(html)
        #expect(rendered.count > 100_000)
    }

    @Test
    func `Many nested elements`() throws {
        func nest(_ depth: Int, content: () -> some HTML.View) -> HTML.AnyView {
            if depth == 0 {
                let c = content()
                return .init(c)
            } else {
                let nested = tag("div") { nest(depth - 1, content: content) }
                return .init(nested)
            }
        }

        let html = nest(50) { HTML.Text("Deep content") }
        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("Deep content"))
    }

    @Test
    func `Many sibling elements`() throws {
        let html = HTML.Group {
            for i in 0..<1000 {
                tag("span") { HTML.Text("Item \(i)") }
            }
        }
        let rendered = try String(html)
        #expect(rendered.contains("Item 0"))
        #expect(rendered.contains("Item 999"))
    }

    @Test
    func `Empty attribute value`() throws {
        let html = tag("input").attribute("value", "")
        let rendered = try String(html)

        #expect(rendered.contains("value"))
    }

    @Test
    func `Boolean attribute`() throws {

        let html = tag("input").attribute("disabled", "")
        let rendered = try String(html)
        #expect(rendered.contains("disabled"))
    }

    @Test
    func `Attribute with special characters in name`() throws {
        let html = tag("div").attribute("data-test-value", "123")
        let rendered = try String(html)
        #expect(rendered.contains("data-test-value=\"123\""))
    }

    @Test
    func `Multiple same attributes`() throws {
        let html = tag("div")
            .attribute("class", "first")
            .attribute("class", "second")
        let rendered = try String(html)

        #expect(rendered.contains("class="))
    }

    @Test
    func `Empty style value`() throws {
        let html = tag("div") { HTML.Text("Content") }
            .inlineStyle("color", "")
        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("<div"))
    }

    @Test
    func `Style with special CSS value`() throws {
        let html = tag("div") { HTML.Text("Content") }
            .inlineStyle("content", "'Hello'")
        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("content:"))
    }

    @Test
    func `Very long style value`() throws {
        let longValue = String(repeating: "a", count: 10_000)
        let html = tag("div") { HTML.Text("Content") }
            .inlineStyle("--custom-prop", longValue)
        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("--custom-prop"))
    }

    @Test
    func `All false conditionals`() throws {
        let html = HTML.Group {
            if false {
                tag("p") { HTML.Text("Never shown") }
            }
            if false {
                tag("span") { HTML.Text("Also never shown") }
            }
        }
        let rendered = try String(html)
        #expect(rendered.isEmpty)
    }

    @Test
    func `Deeply nested conditionals`() throws {
        let a = true
        let b = true
        let c = true

        let html = HTML.Group {
            if a {
                if b {
                    if c {
                        tag("p") { HTML.Text("All true") }
                    }
                }
            }
        }
        let rendered = try String(html)
        #expect(rendered.contains("All true"))
    }

    @Test
    func `Empty array loop`() throws {
        let items: [String] = []
        let html = HTML.Group {
            for item in items {
                tag("li") { HTML.Text(item) }
            }
        }
        let rendered = try String(html)
        #expect(rendered.isEmpty)
    }

    @Test
    func `Single item loop`() throws {
        let items = ["Only one"]
        let html = HTML.Group {
            for item in items {
                tag("li") { HTML.Text(item) }
            }
        }
        let rendered = try String(html)
        #expect(rendered.contains("Only one"))
    }

    @Test
    func `Loop with nil values`() throws {
        let items: [String?] = ["First", nil, "Third", nil, "Fifth"]
        let html = HTML.Group {
            for item in items.compactMap({ $0 }) {
                tag("li") { HTML.Text(item) }
            }
        }
        let rendered = try String(html)
        #expect(rendered.contains("First"))
        #expect(rendered.contains("Third"))
        #expect(rendered.contains("Fifth"))
    }

    @Test
    func `Double type erasure`() throws {
        let original = tag("div") { HTML.Text("Original") }
        let erased: HTML.AnyView = .init(original)
        let doubleErased: HTML.AnyView = .init(erased)
        let rendered = try String(HTML.Document { doubleErased })
        #expect(rendered.contains("Original"))
    }

    @Test
    func `Type erasure with styles`() throws {
        let styled = tag("div") { HTML.Text("Styled") }
            .inlineStyle("color", "red")
        let erased: HTML.AnyView = .init(styled)
        let rendered = try String(HTML.Document { erased })
        #expect(rendered.contains("color:red"))
    }

    @Test
    func `Void element with closing slash`() throws {

        let html = tag("br")
        let rendered = try String(html)
        #expect(
            rendered.contains("<br>") || rendered.contains("<br/>") || rendered.contains("<br />")
        )
    }

    @Test
    func `Void element with attributes`() throws {
        let html = tag("img")
            .attribute("src", "image.png")
            .attribute("alt", "Description")
        let rendered = try String(html)
        #expect(rendered.contains("src=\"image.png\""))
        #expect(rendered.contains("alt=\"Description\""))
    }

    @Test
    func `Raw HTML with unbalanced tags`() throws {
        let html = tag("div") {
            HTML.Raw("<span>Not closed")
        }
        let rendered = try String(html)
        #expect(rendered.contains("<span>Not closed"))
    }

    @Test
    func `Raw HTML with script`() throws {
        let html = HTML.Raw("<script>var x = 1 < 2 && 2 > 1;</script>")
        let rendered = try String(HTML.Group { html })
        #expect(rendered.contains("<script>"))
        #expect(rendered.contains("</script>"))
    }

    @Test
    func `Document with empty head and body`() throws {
        let document = HTML.Document(
            head: { HTML.Empty() },
            body: { HTML.Empty() }
        )
        let rendered = try String(document)
        #expect(rendered.contains("<!doctype html>"))
        #expect(rendered.contains("<html>"))
    }

    @Test
    func `Document with complex head`() throws {
        let document = HTML.Document(
            head: {
                tag("title") { HTML.Text("Title") }
                tag("meta").attribute("charset", "utf-8")
                tag("meta").attribute("name", "viewport").attribute("content", "width=device-width")
                tag("link").attribute("rel", "stylesheet").attribute("href", "style.css")
            },
            body: {
                tag("p") { HTML.Text("Content") }
            }
        )
        let rendered = try String(document)
        #expect(rendered.contains("<title>Title</title>"))
        #expect(rendered.contains("charset=\"utf-8\""))
        #expect(rendered.contains("viewport"))
    }
}

extension `Snapshot Tests` {
    @Suite
    struct `Edge Cases Snapshot Tests` {
        @Test
        func `Complex edge case snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {

                        HTML.Empty()

                        HTML.Text("  ")

                        tag("span") {
                            tag("strong") {
                                HTML.Text("Nested")
                            }
                        }

                        if true {
                            HTML.Text("Shown")
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
                    <div>  <span><strong>Nested</strong></span>Shown
                    </div>
                  </body>
                </html>
                """
            }
        }
    }
}
