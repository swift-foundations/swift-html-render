import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `HTML.Context Tests` {

    @Test
    func `HTML.Context default initialization`() {
        let context = HTML.Context()
        #expect(context.attributes.isEmpty)
        #expect(context.styles.isEmpty)
        #expect(context.currentIndentation.isEmpty)
    }

    @Test
    func `HTML.Context with custom configuration`() {
        let config = HTML.Context.Configuration.pretty
        let context = HTML.Context(config)
        #expect(context.configuration.indentation == config.indentation)
        #expect(context.configuration.newline == config.newline)
    }

    @Test
    func `HTML.Context empty stylesheet`() {
        let context = HTML.Context()
        let stylesheet = context.stylesheet

        #expect(stylesheet.isEmpty)
    }

    @Test
    func `HTML.Context stylesheet with styles`() {
        var context = HTML.Context()
        let style = HTML.Style.Rule(declaration: "color:red")
        _ = context.pushStyle(style)

        let stylesheet = context.stylesheet
        #expect(stylesheet.contains("color:red"))
    }

    @Test
    func `HTML.Context stylesheet with media query`() {
        var context = HTML.Context()
        let atRule = HTML.AtRule(rawValue: "@media (max-width: 768px)")
        let style = HTML.Style.Rule(declaration: "display:none", atRule: atRule)
        _ = context.pushStyle(style)

        let stylesheet = context.stylesheet
        #expect(stylesheet.contains("@media (max-width: 768px)"))
        #expect(stylesheet.contains("display:none"))
    }

    @Test
    func `HTML.Context stylesheet with forceImportant`() {
        var config = HTML.Context.Configuration.default
        config = HTML.Context.Configuration(
            forceImportant: true,
            indentation: config.indentation,
            newline: config.newline,
            reservedCapacity: config.reservedCapacity
        )
        var context = HTML.Context(config)
        let style = HTML.Style.Rule(declaration: "color:blue")
        _ = context.pushStyle(style)

        let stylesheet = context.stylesheet
        #expect(stylesheet.contains("!important"))
    }

    @Test
    func `HTML.Context attribute storage`() {
        var context = HTML.Context()
        context.attributes["class"] = "test-class"
        context.attributes["id"] = "test-id"

        #expect(context.attributes["class"] == "test-class")
        #expect(context.attributes["id"] == "test-id")
        #expect(context.attributes.count == 2)
    }

    @Test
    func `HTML.Context attributes preserve order`() {
        var context = HTML.Context()
        context.attributes["a"] = "first"
        context.attributes["b"] = "second"
        context.attributes["c"] = "third"

        var keys: [String] = []
        context.attributes.forEach { key, _ in keys.append(key) }
        #expect(keys == ["a", "b", "c"])
    }

    @Test
    func `HTML.Context indentation tracking`() {
        var context = HTML.Context(.pretty)
        #expect(context.currentIndentation.isEmpty)

        context.currentIndentation.append(contentsOf: context.configuration.indentation)
        #expect(!context.currentIndentation.isEmpty)
    }
}

extension `Snapshot Tests` {
    @Suite
    struct `HTMLContext Snapshot Tests` {
        @Test
        func `HTML.Context stylesheet rendering snapshot`() {

            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        HTML.Text("Styled content")
                    }
                    .inlineStyle("color", "red")
                    .inlineStyle("padding", "10px")
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                    <style>
                      .padding-0{padding:10px}
                      .color-1{color:red}
                    </style>
                  </head>
                  <body>
                    <div class="padding-0 color-1">Styled content
                    </div>
                  </body>
                </html>
                """
            }
        }
    }
}
