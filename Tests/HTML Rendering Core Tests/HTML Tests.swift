//
//  HTML Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

@Suite
struct `HTML Protocol Tests` {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `HTML Protocol Tests`.Unit {

    @Test
    func `HTML protocol basic functionality`() throws {
        struct TestHTML: HTML.View {
            var body: some HTML.View {
                HTML.Text("test content")
            }
        }

        let html = TestHTML()
        let rendered = try String(html)
        #expect(rendered == "test content")
    }

    @Test
    func `AnyHTML type erasure`() throws {
        let html1 = HTML.Text("first")
        let html2 = HTML.Text("second")

        let anyHTML1: HTML.AnyView = .init(html1)
        let anyHTML2: HTML.AnyView = .init(html2)

        #expect(try String(anyHTML1) == "first")
        #expect(try String(anyHTML2) == "second")
    }
}

// MARK: - Integration

extension `HTML Protocol Tests`.Integration {

    @Test
    func `HTML composition`() throws {
        struct ParentHTML: HTML.View {
            var body: some HTML.View {
                HTML.Group {
                    HTML.Text("parent ")
                    ChildHTML()
                }
            }
        }

        struct ChildHTML: HTML.View {
            var body: some HTML.View {
                HTML.Text("child")
            }
        }

        let html = ParentHTML()
        let rendered = try String(html)
        #expect(rendered == "parent child")
    }
}
