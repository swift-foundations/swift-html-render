//
//  RangeReplaceableCollection UInt8 +HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

public import Render_Primitives
public import Ownership_Mutable_Primitives
public import WHATWG_HTML_Shared

extension RangeReplaceableCollection<UInt8> {
    /// Creates a byte collection from rendered HTML.
    ///
    /// This is the canonical way to render HTML to bytes. The buffer is owned
    /// by `HTML.Context` and extracted after rendering completes.
    ///
    /// ## Canonical Usage
    ///
    /// ```swift
    /// let bytes = [UInt8](myView)
    /// ```
    public init<View: HTML.View>(
        _ view: View,
        configuration: HTML.Context.Configuration? = nil
    ) {
        let state = Ownership.Mutable(HTML.Context(configuration ?? .current))
        var context = Render.Context.html(state: state)
        context.render(view)
        self.init(state.value.bytes)
    }
}

extension RangeReplaceableCollection<UInt8> {
    /// Asynchronously render HTML to a byte collection.
    public init<View: HTML.View>(
        _ view: View,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        await Task.yield()
        let state = Ownership.Mutable(HTML.Context(configuration ?? .current))
        var context = Render.Context.html(state: state)
        context.render(view)
        self.init(state.value.bytes)
    }
}

// MARK: - Document Rendering

extension RangeReplaceableCollection<UInt8> {
    /// Creates a byte collection from a rendered HTML document.
    ///
    /// Uses `_renderHTMLDocument` directly for full document structure
    /// (doctype, html, head, body, two-phase style collection).
    @inlinable
    public init<Document: HTML.Document.`Protocol`>(
        _ document: Document,
        configuration: HTML.Context.Configuration? = nil
    ) {
        var context = HTML.Context(configuration ?? .current)
        Document._renderHTMLDocument(document, context: &context)
        self.init(context.bytes)
    }
}

extension RangeReplaceableCollection<UInt8> {
    /// Asynchronously render an HTML document to a byte collection.
    @inlinable
    public init<Document: HTML.Document.`Protocol`>(
        _ document: Document,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        await Task.yield()
        var context = HTML.Context(configuration ?? .current)
        Document._renderHTMLDocument(document, context: &context)
        self.init(context.bytes)
    }
}
