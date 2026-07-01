// HTML.Document.Protocol Tests.swift
// Tests for HTML.__DocumentProtocol._render — generic rendering path
// used by non-HTML contexts (e.g. PDF). Validates that head and body
// content both render through _render, in document order (head first).
// Distinct from the HTML-output path (_renderHTMLDocument), which is
// tested via String(...) / [UInt8](...) elsewhere.

import HTML_Rendering
import Ownership_Mutable_Primitives
import Render_Primitives
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `HTML.__DocumentProtocol._render Tests` {

    @Test
    func `_render emits head children before body children`() {
        let document = HTML.Document {
            tag("div") {
                HTML.Text("BODY_MARKER")
            }
        } head: {
            tag("title") {
                HTML.Text("HEAD_MARKER")
            }
        }

        let state = Ownership.Mutable(HTML.Context(.default))
        var renderCtx = Render.Context.html(state: state)
        renderCtx.render(document)

        let output = String(decoding: state.value.bytes, as: UTF8.self)

        #expect(output.contains("HEAD_MARKER"), "head children must render through _render")
        #expect(output.contains("BODY_MARKER"), "body children must render through _render")

        if let headIdx = output.range(of: "HEAD_MARKER")?.lowerBound,
           let bodyIdx = output.range(of: "BODY_MARKER")?.lowerBound {
            #expect(headIdx < bodyIdx, "head must render before body in document order")
        }
    }
}
