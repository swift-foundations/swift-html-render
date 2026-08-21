import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `Optional Tests` {

    @Test
    func `Optional some renders content`() throws {
        let optionalHTML: HTML.Text? = HTML.Text("Present")
        let rendered = try String(HTML.Group { optionalHTML })
        #expect(rendered == "Present")
    }

    @Test
    func `Optional none renders nothing`() throws {
        let optionalHTML: HTML.Text? = nil
        let rendered = try String(HTML.Group { optionalHTML })
        #expect(rendered.isEmpty)
    }

    @Test
    func `Optional in builder with some value`() throws {
        struct ConditionalContent: HTML.View {
            let showOptional: Bool

            var body: some HTML.View {
                let optionalContent: HTML.Text? = showOptional ? HTML.Text("Optional present") : nil
                HTML.Group {
                    tag("div") {
                        HTML.Text("Always present")
                    }
                    optionalContent
                }
            }
        }

        let rendered = try String(ConditionalContent(showOptional: true))
        #expect(rendered.contains("Always present"))
        #expect(rendered.contains("Optional present"))
    }

    @Test
    func `Optional in builder with none value`() throws {
        struct ConditionalContent: HTML.View {
            let showOptional: Bool

            var body: some HTML.View {
                let optionalContent: HTML.Text? = showOptional ? HTML.Text("Optional present") : nil
                HTML.Group {
                    tag("div") {
                        HTML.Text("Always present")
                    }
                    optionalContent
                }
            }
        }

        let rendered = try String(ConditionalContent(showOptional: false))
        #expect(rendered.contains("Always present"))
        #expect(!rendered.contains("Optional present"))
    }

    @Test
    func `Nested optional HTML`() throws {
        let inner: HTML.Text? = HTML.Text("Inner")
        let outer: HTML.Text?? = inner

        if let unwrapped = outer, let content = unwrapped {
            let rendered = try String(HTML.Group { content })
            #expect(rendered == "Inner")
        }
    }

    @Test
    func `Optional Group`() throws {
        let group: HTML.Group<HTML.Text>? = HTML.Group {
            HTML.Text("Grouped content")
        }

        let rendered = try String(HTML.Group { group })
        #expect(rendered == "Grouped content")
    }

    @Test
    func `Optional array element`() throws {
        let items = ["Item 1", "Item 2", nil, "Item 4"]

        let html = HTML.Group {
            for item in items {
                let content: HTML.Text? = item.map { HTML.Text($0) }
                content
            }
        }

        let rendered = try String(html)
        #expect(rendered.contains("Item 1"))
        #expect(rendered.contains("Item 2"))
        #expect(rendered.contains("Item 4"))
        #expect(!rendered.contains("Item 3"))
    }

    @Test
    func `Optional propagates context when present`() throws {

        let styledDiv = tag("div") {
            HTML.Text("Styled")
        }
        .inlineStyle("color", "blue")
        let optionalElement: HTML.AnyView? = .init(styledDiv)

        if let element = optionalElement {
            let rendered = try String(HTML.Document { element })
            #expect(rendered.contains("color:blue"))
        } else {
            #expect(Bool(false), "Optional should not be nil")
        }
    }
}

extension `Snapshot Tests` {
    @Suite
    struct `Optional Snapshot Tests` {
        @Test
        func `Optional content snapshot`() {
            struct OptionalList: HTML.View {
                let items: [String?]

                var body: some HTML.View {
                    tag("ul") {
                        for item in items {
                            if let text = item {
                                tag("li") {
                                    HTML.Text(text)
                                }
                            }
                        }
                    }
                }
            }

            snapshot(as: .html) {
                HTML.Document {
                    OptionalList(items: ["First", nil, "Third", "Fourth", nil])
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                  </head>
                  <body>
                    <ul>
                      <li>First
                      </li>
                      <li>Third
                      </li>
                      <li>Fourth
                      </li>
                    </ul>
                  </body>
                </html>
                """
            }
        }
    }
}
