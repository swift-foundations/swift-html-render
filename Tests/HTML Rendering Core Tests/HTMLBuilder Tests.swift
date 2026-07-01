//
//  HTMLBuilder Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

@Suite
struct `HTMLBuilder Tests` {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Unit

extension `HTMLBuilder Tests`.Unit {

    @Test
    func `HTML.Text basic functionality`() throws {
        let text = HTML.Text("Hello, World!")
        let rendered = try String(text)
        #expect(rendered == "Hello, World!")
    }

    @Test
    func `HTML.Text escapes HTML characters`() throws {
        let text = HTML.Text("<script>alert('xss')</script>")
        let rendered = try String(text)
        #expect(rendered.contains("&lt;script&gt;"))
        #expect(!rendered.contains("<script>"))
    }

    @Test
    func `single element`() throws {
        struct TestHTML: HTML.View {
            var body: some HTML.View {
                HTML.Text("single")
            }
        }

        let html = TestHTML()
        let rendered = try String(html)
        #expect(rendered == "single")
    }

    @Test
    func `multiple elements`() throws {
        struct TestHTML: HTML.View {
            var body: some HTML.View {
                HTML.Text("first")
                HTML.Text("second")
                HTML.Text("third")
            }
        }

        let html = TestHTML()
        let rendered = try String(html)
        #expect(rendered == "firstsecondthird")
    }

    @Test
    func `array of elements`() throws {
        struct TestHTML: HTML.View {
            let items = ["first", "second", "third"]

            var body: some HTML.View {
                for item in items {
                    HTML.Text(item)
                }
            }
        }

        let html = TestHTML()
        let rendered = try String(html)
        #expect(rendered == "firstsecondthird")
    }
}

// MARK: - EdgeCase

extension `HTMLBuilder Tests`.EdgeCase {

    @Test
    func `conditional rendering - true branch`() throws {
        struct TestHTML: HTML.View {
            let showContent = true

            var body: some HTML.View {
                if showContent {
                    HTML.Text("visible")
                } else {
                    HTML.Text("hidden")
                }
            }
        }

        let html = TestHTML()
        let rendered = try String(html)
        #expect(rendered == "visible")
    }

    @Test
    func `conditional rendering - false branch`() throws {
        struct TestHTML: HTML.View {
            let showContent = false

            var body: some HTML.View {
                if showContent {
                    HTML.Text("visible")
                } else {
                    HTML.Text("hidden")
                }
            }
        }

        let html = TestHTML()
        let rendered = try String(html)
        #expect(rendered == "hidden")
    }
}
