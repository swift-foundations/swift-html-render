//
//  HTML.Style.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

import Render_Primitives
public import W3C_CSS_Shared
public import WHATWG_HTML_Shared

extension HTML.Element {
    /// A CSS style declaration with optional scope modifiers.
    ///
    /// `HTML.Style` captures a CSS declaration and its context (at-rule, selector, pseudo).
    /// This is the unified representation for all styling operations.
    ///
    /// Create styles from typed CSS properties for compile-time safety:
    /// ```swift
    /// HTML.Style(Color.red)
    /// HTML.Style(Margin.px(10), pseudo: .hover)
    /// ```
    ///
    /// Or from raw declaration strings when needed:
    /// ```swift
    /// HTML.Element.Style(declaration: "color:red")
    /// ```
    public struct Style: Hashable, Sendable {
        /// The CSS declaration string (e.g., "color:red")
        public let declaration: String

        /// Optional at-rule (e.g., @media query)
        public let atRule: HTML.AtRule?

        /// Optional CSS selector prefix
        public let selector: HTML.Selector?

        /// Optional pseudo-class or pseudo-element
        public let pseudo: HTML.Pseudo?

        /// Create a style from a typed CSS property.
        ///
        /// This is the primary API for creating styles with compile-time type safety.
        ///
        /// - Parameters:
        ///   - property: The typed CSS property value.
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init<P: W3C_CSS_Shared.Property>(
            _ property: P,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.declaration = property.declaration.description
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// Create a style from a raw declaration string.
        ///
        /// Use this when you need to bypass the typed property system.
        ///
        /// - Parameters:
        ///   - declaration: The CSS declaration string (e.g., "color:red").
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init(
            declaration: String,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.declaration = declaration
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// The CSS property name extracted from the declaration.
        ///
        /// For "color:red", returns "color".
        /// Used for generating descriptive class names.
        public var propertyName: String {
            if let colonIndex = declaration.firstIndex(of: ":") {
                return String(declaration[..<colonIndex])
            }
            return declaration
        }
    }
}

// Dictionary.Ordered key conformances
extension HTML.Element.Style: Equation.`Protocol` {
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.declaration == rhs.declaration
            && lhs.atRule == rhs.atRule
            && lhs.selector == rhs.selector
            && lhs.pseudo == rhs.pseudo
    }
}

extension HTML.Element.Style: Hash.`Protocol` {
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(declaration)
        hasher.combine(atRule)
        hasher.combine(selector)
        hasher.combine(pseudo)
    }
}
