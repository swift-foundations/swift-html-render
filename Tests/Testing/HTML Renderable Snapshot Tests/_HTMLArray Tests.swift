import HTML_Rendering_Core
import HTML_Snapshot_Test_Support
import Testing

@Suite
struct `_Array Tests` {

    @Test
    func `_Array renders multiple elements`() throws {

        let html = HTML.Group {
            for item in ["A", "B", "C"] {
                tag("li") {
                    HTML.Text(item)
                }
            }
        }

        let rendered = try String(html)
        #expect(rendered.contains("<li>A</li>"))
        #expect(rendered.contains("<li>B</li>"))
        #expect(rendered.contains("<li>C</li>"))
    }

    @Test
    func `_Array with empty array`() throws {
        let items: [String] = []
        let html = HTML.Group {
            for item in items {
                tag("li") {
                    HTML.Text(item)
                }
            }
        }

        let rendered = try String(html)
        #expect(rendered.isEmpty)
    }

    @Test
    func `_Array with single element`() throws {
        let html = HTML.Group {
            for item in ["Only"] {
                tag("span") {
                    HTML.Text(item)
                }
            }
        }

        let rendered = try String(html)
        #expect(rendered == "<span>Only</span>")
    }

    @Test
    func `_Array with nested elements`() throws {
        let items = [("Title 1", "Content 1"), ("Title 2", "Content 2")]
        let html = HTML.Group {
            for (title, content) in items {
                tag("article") {
                    tag("h2") {
                        HTML.Text(title)
                    }
                    tag("p") {
                        HTML.Text(content)
                    }
                }
            }
        }

        let rendered = try String(html)
        #expect(rendered.contains("<article>"))
        #expect(rendered.contains("Title 1"))
        #expect(rendered.contains("Content 1"))
        #expect(rendered.contains("Title 2"))
        #expect(rendered.contains("Content 2"))
    }

    @Test
    func `_Array with attributes`() throws {
        let items = ["item-1", "item-2", "item-3"]
        let html = HTML.Group {
            for id in items {
                tag("div") {
                    HTML.Text(id)
                }
                .attribute("id", id)
            }
        }

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("id=\"item-1\""))
        #expect(rendered.contains("id=\"item-2\""))
        #expect(rendered.contains("id=\"item-3\""))
    }

    @Test
    func `_Array with indices`() throws {
        let items = ["First", "Second", "Third"]
        let html = HTML.Group {
            for (index, item) in items.enumerated() {
                tag("div") {
                    HTML.Text("\(index): \(item)")
                }
            }
        }

        let rendered = try String(html)
        #expect(rendered.contains("0: First"))
        #expect(rendered.contains("1: Second"))
        #expect(rendered.contains("2: Third"))
    }

    @Test
    func `_Array via map`() throws {
        let items = ["Alpha", "Beta", "Gamma"]
        let html = items.map { item in
            tag("option") {
                HTML.Text(item)
            }
        }

        let rendered = try String(html)
        #expect(rendered.contains("<option>Alpha</option>"))
        #expect(rendered.contains("<option>Beta</option>"))
        #expect(rendered.contains("<option>Gamma</option>"))
    }

    @Test
    func `_Array propagates context correctly`() throws {
        let items = ["Red", "Blue"]
        let html = HTML.Document {
            for item in items {
                tag("span") {
                    HTML.Text(item)
                }
                .inlineStyle("color", item.lowercased())
            }
        }

        let rendered = try String(html)
        #expect(rendered.contains("color:red"))
        #expect(rendered.contains("color:blue"))
    }
}

extension `Snapshot Tests` {
    @Suite
    struct ` Array Snapshot Tests` {
        @Test
        func `_Array list rendering snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("ul") {
                        for item in ["Home", "About", "Contact"] {
                            tag("li") {
                                tag("a") {
                                    HTML.Text(item)
                                }
                                .attribute("href", "/\(item.lowercased())")
                            }
                        }
                    }
                    .attribute("class", "nav-menu")
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                  </head>
                  <body>
                    <ul class="nav-menu">
                      <li><a href="/home">Home</a>
                      </li>
                      <li><a href="/about">About</a>
                      </li>
                      <li><a href="/contact">Contact</a>
                      </li>
                    </ul>
                  </body>
                </html>
                """
            }
        }
    }
}
