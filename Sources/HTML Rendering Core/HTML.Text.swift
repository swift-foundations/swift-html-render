//
//  HTML.Text.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import ASCII
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    /// Represents plain text content in HTML, with proper escaping.
    ///
    /// `HTML.Text` handles escaping special characters in text content to ensure
    /// proper HTML rendering without security vulnerabilities.
    public struct Text: HTML.View, Sendable {
        /// The raw text content.
        public let text: String

        /// Creates a new HTML text component with the given text.
        public init(_ text: String) {
            self.text = text
        }

        public typealias Body = Never
        public var body: Never { fatalError() }

        /// Renders the text content via the context's text method.
        public static func _render(
            _ view: borrowing Self, context: inout Render.Context
        ) {
            context.text(view.text)
        }

        /// Concatenates two HTML text components.
        public static func + (lhs: Self, rhs: Self) -> Self {
            HTML.Text(lhs.text + rhs.text)
        }
    }
}

/// Allows HTML text to be created from string literals.
extension HTML.Text: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

/// Allows HTML text to be created with string interpolation.
extension HTML.Text: ExpressibleByStringInterpolation {}
