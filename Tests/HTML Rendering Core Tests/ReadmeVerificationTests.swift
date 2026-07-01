//
//  ReadmeVerificationTests.swift
//  swift-html-rendering
//

@_spi(DynamicHTML) import HTML_Rendering_Core
import HTML_Rendering
import HTML_Standard
import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

@Suite
struct `README Verification Tests` {
    @Suite struct Unit {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `README Verification Tests`.Unit {

    @Test
    func `tag function`() {
        let element = tag("p") { "Paragraph text" }
        let html = try! String(element)

        #expect(html.contains("Paragraph text"))
        #expect(html.contains("<p>"))
    }

    @Test
    func `String rendering`() throws {
        struct Simple: HTML.View {
            var body: some HTML.View {
                tag("span") { "Test" }
            }
        }

        let html = try String(Simple())
        #expect(html.contains("Test"))
    }

    @Test
    func `bytes rendering`() {
        struct Simple: HTML.View {
            var body: some HTML.View {
                tag("span") { "Test" }
            }
        }

        let bytes = ContiguousArray(Simple())
        #expect(!bytes.isEmpty)

        let string = String(decoding: bytes, as: UTF8.self)
        #expect(string.contains("Test") == true)
    }

    @Test
    func `attribute method`() {
        let element = tag("a") { "Link" }
            .attribute("href", "https://example.com")
            .attribute("target", "_blank")

        let html = try! String(element)
        #expect(html.contains("href=\"https://example.com\""))
        #expect(html.contains("target=\"_blank\""))
    }

    @Test
    func `inline style method`() {
        let element = tag("div") { "Styled" }
            .inlineStyle("color", "red")
            .inlineStyle("font-size", "16px")

        let html = try! String(element)
        #expect(html.contains("Styled"))
    }

    @Test
    func `string interpolation in HTML content`() {
        struct Interpolated: HTML.View {
            let value: String
            var body: some HTML.View {
                tag("p") { "Value: \(value)" }
            }
        }

        let html = try! String(Interpolated(value: "test123"))
        #expect(html.contains("Value: test123"))
    }

    @Test
    func `HTML protocol conformance`() {
        struct CustomComponent: HTML.View {
            var body: some HTML.View {
                tag("div") { "Content" }
            }
        }

        let component = CustomComponent()
        let html = try! String(component)

        #expect(html.contains("Content"))
        #expect(html.contains("<div>"))
    }
}

// MARK: - Integration

extension `README Verification Tests`.Integration {

    @Test
    func `basic usage - Greeting component`() throws {
        struct Greeting: HTML.View {
            let name: String
            var body: some HTML.View {
                tag("h1") { "Hello, \(name)!" }
            }
        }

        let greeting = Greeting(name: "World")
        let htmlString: String = try String(greeting)
        let htmlBytes: ContiguousArray = .init(greeting)

        #expect(htmlString.contains("Hello, World!"))
        #expect(htmlString.contains("<h1>"))
        #expect(!htmlBytes.isEmpty)
    }

    @Test
    func `Swift-HTML integration - PointFreeHTML APIs`() {
        struct StyledComponent: HTML.View {
            var body: some HTML.View {
                tag("div") {
                    tag("a") { "Styled Heading" }
                        .attribute("href", "#")
                        .inlineStyle("color", "blue")
                        .inlineStyle("font-size", "24px")
                        .inlineStyle("margin-bottom", "16px")
                }
            }
        }

        let component = StyledComponent()
        let html = try! String(component)

        #expect(html.contains("Styled Heading"))
        #expect(html.contains("href=\"#\""))
    }

    @Test
    func `server integration - Greeting route logic`() throws {
        let name = "TestUser"

        struct Greeting: HTML.View {
            let name: String
            var body: some HTML.View {
                tag("h1") { "Hello, \(name)!" }
            }
        }

        let response = try String(Greeting(name: name))

        #expect(response.contains("Hello, TestUser!"))
        #expect(response.contains("<h1>"))
    }

    @Test
    func `HTMLBuilder result builder`() {
        struct MultiElement: HTML.View {
            var body: some HTML.View {
                tag("div") {
                    tag("h1") { "Title" }
                    tag("p") { "Paragraph" }
                }
            }
        }

        let html = try! String(MultiElement())
        #expect(html.contains("Title"))
        #expect(html.contains("Paragraph"))
        #expect(html.contains("<h1>"))
        #expect(html.contains("<p>"))
    }

    @Test
    func `nested components`() {
        struct Inner: HTML.View {
            var body: some HTML.View {
                tag("span") { "Inner" }
            }
        }

        struct Outer: HTML.View {
            var body: some HTML.View {
                tag("div") {
                    Inner()
                }
            }
        }

        let html = try! String(Outer())
        #expect(html.contains("Inner"))
        #expect(html.contains("<div>"))
        #expect(html.contains("<span>"))
    }
}
