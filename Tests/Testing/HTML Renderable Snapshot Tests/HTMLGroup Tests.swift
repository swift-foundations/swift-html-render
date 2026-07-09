//
//  GroupTests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import HTML_Rendering_Core
import HTML_Snapshot_Test_Support
import Testing

@Suite
struct `Group Tests` {

    @Test
    func `Group with multiple elements`() throws {
        let group = HTML.Group {
            HTML.Text("first")
            HTML.Text("second")
            HTML.Text("third")
        }

        let rendered = try String(group)
        #expect(rendered == "firstsecondthird")
    }

    @Test
    func `Group with mixed content types`() throws {
        let group = HTML.Group {
            HTML.Text("text")
            tag("span") {
                HTML.Text("span content")
            }
            HTML.Text("more text")
        }

        let rendered = try String(HTML.Document { group })
        #expect(rendered.contains("text"))
        #expect(rendered.contains("<span>"))
        #expect(rendered.contains("span content"))
        #expect(rendered.contains("</span>"))
        #expect(rendered.contains("more text"))
    }

    @Test
    func `Empty Group`() throws {
        let group = HTML.Group {
            HTML.Empty()
        }

        let rendered = try String(group)
        #expect(rendered.isEmpty)
    }

    @Test
    func `Nested Groups`() throws {
        let outerGroup = HTML.Group {
            HTML.Text("outer start")
            HTML.Group {
                HTML.Text("inner1")
                HTML.Text("inner2")
            }
            HTML.Text("outer end")
        }

        let rendered = try String(outerGroup)
        #expect(rendered == "outer startinner1inner2outer end")
    }

    @Test
    func `Group with conditionals`() throws {
        struct TestHTML: HTML.View {
            let showFirst = true
            let showSecond = false

            var body: some HTML.View {
                HTML.Group {
                    if showFirst {
                        HTML.Text("first")
                    }
                    if showSecond {
                        HTML.Text("second")
                    }
                    HTML.Text("always")
                }
            }
        }

        let html = TestHTML()
        let rendered = try String(html)
        #expect(rendered == "firstalways")
    }

    @Test
    func `Group as transparent container`() throws {
        let element = tag("div") {
            HTML.Group {
                tag("p") { HTML.Text("paragraph 1") }
                tag("p") { HTML.Text("paragraph 2") }
            }
        }

        let rendered = try String(element)
        #expect(rendered.contains("<div>"))
        #expect(rendered.contains("<p>paragraph 1</p>"))
        #expect(rendered.contains("<p>paragraph 2</p>"))
        #expect(rendered.contains("</div>"))
        #expect(!rendered.contains("<group>") && !rendered.contains("</group>"))
    }
}

// MARK: - Snapshot Tests

extension `Snapshot Tests` {
    @Suite
    struct GroupSnapshotTests {
        @Test
        func `Group transparent container snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        HTML.Group {
                            tag("h2") {
                                HTML.Text("Section Title")
                            }
                            tag("p") {
                                HTML.Text("First paragraph in the group.")
                            }
                            tag("p") {
                                HTML.Text("Second paragraph in the group.")
                            }
                            tag("ul") {
                                tag("li") {
                                    HTML.Text("List item 1")
                                }
                                tag("li") {
                                    HTML.Text("List item 2")
                                }
                            }
                        }
                    }
                    .attribute("class", "content-wrapper")
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                  </head>
                  <body>
                    <div class="content-wrapper">
                      <h2>Section Title
                      </h2>
                      <p>First paragraph in the group.
                      </p>
                      <p>Second paragraph in the group.
                      </p>
                      <ul>
                        <li>List item 1
                        </li>
                        <li>List item 2
                        </li>
                      </ul>
                    </div>
                  </body>
                </html>
                """
            }
        }
    }
}
