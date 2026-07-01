//
//  HTML.Document.Protocol.swift
//
//
//  Created by Point-Free, Inc
//

import Render_Primitives
import Dictionary_Ordered_Primitives
import Ownership_Mutable_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    /// Underlying protocol for HTML documents — internal-intended.
    ///
    /// The `__` prefix signals that consumers should reach this protocol
    /// through its public-intended path `HTML.Document.\`Protocol\``, which
    /// is a typealias declared alongside the `HTML.Document` struct. The
    /// hoisted shape exists because Swift cannot resolve
    /// `HTML.Document.\`Protocol\`` as the conformance target of
    /// `HTML.Document` itself (circular reference at name resolution), so
    /// the conforming struct must reach the underlying symbol directly
    /// while the public API stays on the dotted path.
    public protocol __DocumentProtocol: HTML.View {
        associatedtype Head: HTML.View

        @HTML.Builder
        var head: Head { get }
    }
}

extension HTML.__DocumentProtocol {
    /// Renders document head then body content through the generic `_render`
    /// path.
    ///
    /// Documents are HTML-specific (doctype, html/head/body structure). The
    /// full document structure (with `<!doctype html>`, `<html>`, `<head>`,
    /// `<body>` wrapper tags) is produced by `_renderHTMLDocument`, called
    /// directly by HTML output entry points. Through the generic rendering
    /// path used by non-HTML contexts (e.g. PDF), head and body content
    /// are emitted in document order — head first — so consumers can read
    /// `<style>` blocks, metadata, and other head content for cascade
    /// application or document-level configuration.
    public static func _render(
        _ html: borrowing Self,
        context: inout Render.Context
    ) {
        context.render(html.head)
        context.render(html.body)
    }

    /// Full HTML document rendering with two-phase style collection.
    ///
    /// Called directly by HTML entry points for complete document output.
    public static func _renderHTMLDocument(
        _ html: borrowing Self,
        context: inout HTML.Context
    ) {
        let configuration = context.configuration
        let indent = configuration.indentation

        // Phase 1: Render body to collect styles
        let bodyState = Ownership.Mutable(HTML.Context(configuration))
        bodyState.value.currentIndentation = indent + indent
        var bodyRenderCtx = Render.Context.html(state: bodyState)
        bodyRenderCtx.render(html.body)
        let bodyBytes = bodyState.value.bytes

        // Transfer collected styles to main context
        bodyState.value.styles.forEach { key, value in
            context.styles[key] = value
        }

        // Phase 2: Write document structure
        let newline = configuration.newline

        // Head and body content are rendered into fresh contexts, where the first
        // child emits its indentation but no leading newline (the newline is guarded
        // on a non-empty buffer). Block content therefore begins with the content
        // indentation (`indent + indent`); inline/text/void content does not. We use
        // that to decide whether to break before the spliced content, so block bodies
        // break (`<body>\n    <main>`) while inline bodies stay on the tag line
        // (`<body>Hello`).
        let contentIndent = indent + indent

        // <!doctype html>
        context.bytes.append(contentsOf: [UInt8].html.tag.doctype)

        // <html>
        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: [UInt8].html.tag.open)

        // <head>
        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: indent)
        context.bytes.append(contentsOf: [UInt8].html.tag.headOpen)

        // Render head content into separate context
        let headState = Ownership.Mutable(HTML.Context(configuration))
        headState.value.currentIndentation = indent + indent
        var headRenderCtx = Render.Context.html(state: headState)
        headRenderCtx.render(html.head)
        let headBytes = headState.value.bytes
        if headBytes.starts(with: contentIndent) {
            context.bytes.append(contentsOf: newline)
        }
        context.bytes.append(contentsOf: headBytes)
        headState.value.styles.forEach { key, value in
            context.styles[key] = value
        }

        // Add collected styles if any
        let styleContentIndent = indent + indent + indent
        let stylesheetBytes = bodyState.value.stylesheetBytes(baseIndentation: styleContentIndent)
        if !bodyState.value.styles.isEmpty {
            context.bytes.append(contentsOf: newline)
            context.bytes.append(contentsOf: indent)
            context.bytes.append(contentsOf: indent)
            context.bytes.append(contentsOf: [UInt8].html.tag.styleOpen)
            context.bytes.append(contentsOf: stylesheetBytes)
            context.bytes.append(contentsOf: newline)
            context.bytes.append(contentsOf: indent)
            context.bytes.append(contentsOf: indent)
            context.bytes.append(contentsOf: [UInt8].html.tag.styleClose)
        }

        // </head>
        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: indent)
        context.bytes.append(contentsOf: [UInt8].html.tag.headClose)

        // <body>
        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: indent)
        context.bytes.append(contentsOf: [UInt8].html.tag.bodyOpen)

        // Append pre-rendered body bytes
        if bodyBytes.starts(with: contentIndent) {
            context.bytes.append(contentsOf: newline)
        }
        context.bytes.append(contentsOf: bodyBytes)

        // </body>
        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: indent)
        context.bytes.append(contentsOf: [UInt8].html.tag.bodyClose)

        // </html>
        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: [UInt8].html.tag.close)
    }
}

extension HTML.__DocumentProtocol {
    /// Asynchronously render this document to a complete byte array.
    @inlinable
    public func asyncDocumentBytes(
        configuration: HTML.Context.Configuration? = nil
    ) async -> [UInt8] {
        await [UInt8](self, configuration: configuration)
    }

    /// Asynchronously render this document to a String.
    @inlinable
    public func asyncDocumentString(
        configuration: HTML.Context.Configuration? = nil
    ) async -> String {
        await String(self, configuration: configuration)
    }
}
