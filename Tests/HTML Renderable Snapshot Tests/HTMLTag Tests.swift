//
//  HTML.Tag Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `HTML.Tag Tests` {

    @Test
    func `HTML.Tag basic functionality`() throws {
        let tag: some HTML.View = tag("div") {
            HTML.Text("content")
        }

        let rendered = try String(HTML.Document { tag })
        #expect(rendered.contains("<div>"))
        #expect(rendered.contains("content"))
        #expect(rendered.contains("</div>"))
    }

    @Test
    func `HTML.Tag.Text for text content`() throws {
        let textTag = tag("span") {
            "text content"
        }

        let rendered = try String(HTML.Document { textTag })
        #expect(rendered.contains("<span>"))
        #expect(rendered.contains("text content"))
        #expect(rendered.contains("</span>"))
    }

    @Test
    func `HTMLVoidTag self-closing`() throws {
        let voidTag = tag("br")

        let rendered = try String(HTML.Document { voidTag })
        #expect(rendered.contains("<br"))
        #expect(rendered.contains("/>") || rendered.contains(">"))
        #expect(!rendered.contains("</br>"))
    }

    @Test
    func `HTMLVoidTag with attributes`() throws {
        let voidTag = tag("input")
            .attribute("type", "text")
            .attribute("name", "username")

        let rendered = try String(HTML.Document { voidTag })
        #expect(rendered.contains("<input"))
        #expect(rendered.contains("type=\"text\""))
        #expect(rendered.contains("name=\"username\""))
        #expect(!rendered.contains("</input>"))
    }

    @Test
    func `Nested HTML.Tags`() throws {
        let outerTag = tag("div") {
            tag("p") {
                HTML.Text("nested paragraph")
            }
        }

        let rendered = try String(HTML.Document { outerTag })
        #expect(rendered.contains("<div>"))
        #expect(rendered.contains("<p>"))
        #expect(rendered.contains("nested paragraph"))
        #expect(rendered.contains("</p>"))
        #expect(rendered.contains("</div>"))
    }

    @Test
    func `Empty HTML.Tag`() throws {
        let tag = tag("div")

        let rendered = try String(HTML.Document { tag })
        #expect(rendered.contains("<div>"))
        #expect(rendered.contains("</div>"))
    }
}

// MARK: - Snapshot Tests

extension `Snapshot Tests` {
    @Suite
    struct HTMLTagSnapshotTests {
        @Test
        func `HTML.Tag semantic structure snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("main") {
                        tag("header") {
                            tag("nav") {
                                tag("h1") {
                                    "Site Navigation"
                                }
                                tag("ul") {
                                    tag("li") {
                                        tag("a") {
                                            "Home"
                                        }
                                    }
                                    tag("li") {
                                        tag("a") {
                                            "About"
                                        }
                                    }
                                }
                            }
                        }

                        tag("section") {
                            tag("h2") {
                                "Main Content"
                            }
                            tag("p") {
                                "This demonstrates semantic HTML structure using HTML.Tag components."
                            }
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
                    <main>
                      <header>
                        <nav>
                          <h1>Site Navigation
                          </h1>
                          <ul>
                            <li><a>Home</a>
                            </li>
                            <li><a>About</a>
                            </li>
                          </ul>
                        </nav>
                      </header>
                      <section>
                        <h2>Main Content
                        </h2>
                        <p>This demonstrates semantic HTML structure using HTML.Tag components.
                        </p>
                      </section>
                    </main>
                  </body>
                </html>
                """
            }
        }

        @Test
        func `HTMLVoidTag form elements snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("form") {
                        tag("fieldset") {
                            tag("legend") {
                                "Contact Information"
                            }

                            tag("input")
                                .attribute("type", "text")
                                .attribute("name", "name")
                                .attribute("placeholder", "Your Name")

                            tag("br")

                            tag("input")
                                .attribute("type", "email")
                                .attribute("name", "email")
                                .attribute("placeholder", "Your Email")

                            tag("hr")

                            tag("button") {
                                HTML.Text("Submit Form")
                            }
                            .attribute("type", "submit")
                        }
                    }
                    .attribute("method", "post")
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                  </head>
                  <body>
                    <form method="post">
                      <fieldset>
                        <legend>Contact Information
                        </legend><input type="text" name="name" placeholder="Your Name"><br><input type="email" name="email" placeholder="Your Email">
                        <hr><button type="submit">Submit Form</button>
                      </fieldset>
                    </form>
                  </body>
                </html>
                """
            }
        }
    }
}
