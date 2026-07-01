//
//  HTML.Document.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 22/07/2025.
//

public import Render_Primitives
public import WHATWG_HTML_Shared

#if canImport(SwiftUI)
@preconcurrency public import SwiftUI
#endif

extension HTML {
    /// A complete HTML document with head and body sections.
    ///
    /// `HTML.Document` represents a full HTML page with proper structure including
    /// doctype, html, head, and body elements. Use this type when you need
    /// to render a complete HTML document rather than just a fragment.
    ///
    /// Example:
    /// ```swift
    /// let page = HTML.Document {
    ///     div {
    ///         h1 { "Welcome" }
    ///         p { "Hello, World!" }
    ///     }
    /// } head: {
    ///     title { "My Page" }
    ///     meta().charset("utf-8")
    /// }
    /// ```
    public struct Document<Body: HTML.View, Head: HTML.View>: HTML.__DocumentProtocol {
        /// Split the unified `Body` associated type between the two
        /// protocols with per-protocol `@_implements` stamps:
        /// `Render.View.Body = Body` (the generic parameter) and
        /// `SwiftUI.View.Body = Never` (aligns with `NSViewRepresentable`'s
        /// `where Self.Body == Never`). Without this split, Swift merges
        /// the two same-named associated types into one binding, and no
        /// single type can satisfy `Body: HTML.View` and `Body == Never`
        /// simultaneously. Both stamps are needed — a single stamp leaves
        /// one protocol's `Body` to unify with the other's.
        @_implements(Render.View, Body)
        public typealias _RenderingBody = Body

        #if canImport(SwiftUI)
        @_implements(SwiftUI.View, Body)
        public typealias _SwiftUIBody = Never
        #endif

        public let head: Head
        public let body: Body

        /// Creates a new HTML document.
        ///
        /// - Parameters:
        ///   - body: A builder closure that returns the body content.
        ///   - head: A builder closure that returns the head content. Defaults to empty.
        public init(
            @HTML.Builder body: () -> Body,
            @HTML.Builder head: () -> Head = { HTML.Empty() }
        ) {
            self.body = body()
            self.head = head()
        }
    }
}

extension HTML.Document {
    /// Creates a new HTML document with head specified first.
    ///
    /// This overload allows specifying head before body for cases where
    /// that ordering reads more naturally.
    ///
    /// - Parameters:
    ///   - head: A builder closure that returns the head content. Defaults to empty.
    ///   - body: A builder closure that returns the body content.
    @_disfavoredOverload
    public init(
        @HTML.Builder head: () -> Head = { HTML.Empty() },
        @HTML.Builder body: () -> Body
    ) {
        self.body = body()
        self.head = head()
    }
}

extension HTML.Document: Sendable where Body: Sendable, Head: Sendable {}

/// Public-intended path for the document protocol.
///
/// `HTML.__DocumentProtocol` is the hoisted underlying protocol — the `__`
/// prefix signals internal-intended. Consumers should use
/// `HTML.Document.\`Protocol\`` (this typealias) instead. The struct's
/// own conformance list spells the underlying symbol because Swift cannot
/// resolve `HTML.Document.\`Protocol\`` as the conformance target of
/// `HTML.Document` itself (circular name resolution).
extension HTML.Document {
    public typealias `Protocol` = HTML.__DocumentProtocol
}
