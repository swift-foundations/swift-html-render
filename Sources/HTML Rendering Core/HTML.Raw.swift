//
//  HTML.Raw.swift
//  swift-html-rendering
//
//  Created by Point-Free, Inc
//

import ASCII
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    /// Represents raw, unescaped HTML content.
    ///
    /// `HTML.Raw` allows you to insert raw HTML content without any escaping.
    /// This is HTML-specific: in foreign rendering contexts, raw bytes are a no-op.
    ///
    /// - Warning: Using `HTML.Raw` with user-provided content can lead to XSS attacks.
    ///   Only use with trusted content that you have full control over.
    public struct Raw: HTML.View, Sendable {
        /// The raw HTML bytes.
        public let bytes: [UInt8]

        /// Creates raw HTML content from a string.
        public init(_ string: String) {
            self.bytes = Array(string.utf8)
        }

        /// Creates raw HTML content from bytes.
        public init(_ bytes: [UInt8]) {
            self.bytes = bytes
        }

        public typealias Body = Never
        public var body: Never { fatalError() }

        /// Renders raw bytes directly to the buffer via `writeRawBytes`.
        /// No-op for foreign contexts (raw HTML has no semantic equivalent).
        public static func _render(
            _ view: borrowing Self, context: inout Render.Context
        ) {
            context.write(raw: view.bytes)
        }
    }
}
