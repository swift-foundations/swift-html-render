import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `HTMLVoidTag Tests` {

    @Test
    func `HTMLVoidTag creates self-closing element`() throws {
        let br = tag("br")
        let element = br
        let rendered = try String(element)
        #expect(rendered.contains("<br"))
        #expect(!rendered.contains("</br>"))
    }

    @Test
    func `HTMLVoidTag br element`() throws {
        let br = tag("br")
        let rendered = try String(br)
        #expect(rendered.contains("<br>"))
    }

    @Test
    func `HTMLVoidTag hr element`() throws {
        let hr = tag("hr")
        let rendered = try String(hr)
        #expect(rendered.contains("<hr>"))
    }

    @Test
    func `HTMLVoidTag img element`() throws {
        let img = tag("img")
        let element =
            img
            .attribute("src", "/image.jpg")
            .attribute("alt", "Description")

        let rendered = try String(HTML.Document { element })
        #expect(rendered.contains("<img"))
        #expect(rendered.contains("src=\"/image.jpg\""))
        #expect(rendered.contains("alt=\"Description\""))
        #expect(!rendered.contains("</img>"))
    }

    @Test
    func `HTMLVoidTag input element`() throws {
        let input = tag("input")
        let element =
            input
            .attribute("type", "text")
            .attribute("name", "username")
            .attribute("placeholder", "Enter username")

        let rendered = try String(HTML.Document { element })
        #expect(rendered.contains("<input"))
        #expect(rendered.contains("type=\"text\""))
        #expect(rendered.contains("name=\"username\""))
    }

    @Test
    func `HTMLVoidTag meta element`() throws {
        let meta = tag("meta")
        let element =
            meta
            .attribute("charset", "utf-8")

        let rendered = try String(HTML.Document { element })
        #expect(rendered.contains("<meta"))
        #expect(rendered.contains("charset=\"utf-8\""))
    }

    @Test
    func `HTMLVoidTag link element`() throws {
        let link = tag("link")
        let element =
            link
            .attribute("rel", "stylesheet")
            .attribute("href", "/styles.css")

        let rendered = try String(HTML.Document { element })
        #expect(rendered.contains("<link"))
        #expect(rendered.contains("rel=\"stylesheet\""))
        #expect(rendered.contains("href=\"/styles.css\""))
    }

    @Test
    func `HTMLVoidTag with multiple attributes`() throws {
        let input = tag("input")
        let element =
            input
            .attribute("type", "email")
            .attribute("name", "email")
            .attribute("id", "email-field")
            .attribute("required", "")
            .attribute("placeholder", "your@email.com")

        let rendered = try String(HTML.Document { element })
        #expect(rendered.contains("type=\"email\""))
        #expect(rendered.contains("name=\"email\""))
        #expect(rendered.contains("id=\"email-field\""))
        #expect(rendered.contains("required"))
        #expect(rendered.contains("placeholder=\"your@email.com\""))
    }

    @Test
    func `HTMLVoidTag in form`() throws {
        let input = tag("input")
        let br = tag("br")

        let html = tag("form") {
            tag("label") { HTML.Text("Name:") }
            br
            input.attribute("type", "text").attribute("name", "name")
            br
            tag("label") { HTML.Text("Email:") }
            br
            input.attribute("type", "email").attribute("name", "email")
        }

        let rendered = try String(HTML.Document { html })
        #expect(rendered.contains("<form>"))
        #expect(rendered.contains("<br>"))
        #expect(rendered.contains("<input"))
    }

    @Test
    func `HTMLVoidTag in head`() throws {
        let meta = tag("meta")
        let link = tag("link")

        let document = HTML.Document {
            HTML.Empty()
        } head: {
            meta.attribute("charset", "utf-8")
            meta.attribute("name", "viewport").attribute("content", "width=device-width")
            link.attribute("rel", "stylesheet").attribute("href", "/styles.css")
        }

        let rendered = try String(document)
        #expect(rendered.contains("charset=\"utf-8\""))
        #expect(rendered.contains("name=\"viewport\""))
        #expect(rendered.contains("rel=\"stylesheet\""))
    }
}

extension `Snapshot Tests` {
    @Suite
    struct `HTMLVoid Tag Snapshot Tests` {
        @Test
        func `HTMLVoidTag form elements snapshot`() {
            let input = tag("input")
            let br = tag("br")

            snapshot(as: .html) {
                HTML.Document {
                    tag("form") {
                        tag("fieldset") {
                            tag("legend") { HTML.Text("Contact Form") }
                            tag("label") { HTML.Text("Name:") }
                            br
                            input
                                .attribute("type", "text")
                                .attribute("name", "name")
                            br
                            br
                            tag("label") { HTML.Text("Email:") }
                            br
                            input
                                .attribute("type", "email")
                                .attribute("name", "email")
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
                        <legend>Contact Form
                        </legend><label>Name:</label><br><input type="text" name="name"><br><br><label>Email:</label><br><input type="email" name="email">
                      </fieldset>
                    </form>
                  </body>
                </html>
                """
            }
        }
    }
}
