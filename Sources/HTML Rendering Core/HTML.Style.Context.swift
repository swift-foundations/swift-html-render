//
//  HTML.Element.Style.Context.swift
//  swift-html-rendering
//
//  TaskLocal-based context for CSS styling.
//

public import WHATWG_HTML_Shared

extension HTML.Element.Style {
    /// Context for CSS styling that captures at-rule, selector, and pseudo state.
    ///
    /// This context is propagated via Swift's TaskLocal mechanism, enabling
    /// implicit parameter passing for media queries, selectors, and pseudo-states.
    ///
    /// ## Usage
    ///
    /// Set context for a scope:
    /// ```swift
    /// HTML.Element.Style.Context.$current.withValue(.init(atRule: .dark)) {
    ///     div.css.color(.red)  // Applies color with @media dark
    /// }
    /// ```
    ///
    /// Or use the convenience modifiers on CSS:
    /// ```swift
    /// div.css.dark { $0.color(.red) }
    /// button.css.hover { $0.backgroundColor(.blue) }
    /// ```
    ///
    /// ## Context Merging
    ///
    /// Nested contexts are merged, allowing composition:
    /// ```swift
    /// div.css.dark {
    ///     $0.hover {
    ///         $0.color(.white)  // Gets both @media dark AND :hover
    ///     }
    /// }
    /// ```
    public struct Context: Sendable, Hashable {
        /// Optional at-rule (e.g., media query).
        public let atRule: HTML.AtRule?

        /// Optional CSS selector prefix.
        public let selector: HTML.Selector?

        /// Optional pseudo-class or pseudo-element.
        public let pseudo: HTML.Pseudo?

        /// The default empty context.
        public static let `default` = Context(atRule: nil, selector: nil, pseudo: nil)

        /// TaskLocal storage for the current style context.
        ///
        /// Use `$current.withValue(_:operation:)` to set context for a scope:
        /// ```swift
        /// HTML.Element.Style.Context.$current.withValue(.init(atRule: .dark)) {
        ///     // All styles in this scope get the dark media query
        /// }
        /// ```
        @TaskLocal public static var current: Context = .default

        /// Creates a style context with the specified modifiers.
        ///
        /// - Parameters:
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional CSS selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init(
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// Creates a context with a media query.
        ///
        /// - Parameter media: The media query to apply.
        public init(media: HTML.AtRule.Media?) {
            self.atRule = media
            self.selector = nil
            self.pseudo = nil
        }

        /// Creates a context with a pseudo-class or pseudo-element.
        ///
        /// - Parameter pseudo: The pseudo-class or pseudo-element.
        public init(pseudo: HTML.Pseudo?) {
            self.atRule = nil
            self.selector = nil
            self.pseudo = pseudo
        }

        /// Creates a context with a selector.
        ///
        /// - Parameter selector: The CSS selector prefix.
        public init(selector: HTML.Selector?) {
            self.atRule = nil
            self.selector = selector
            self.pseudo = nil
        }

        // MARK: - Composition

        /// Merges this context with another, with the other taking precedence for non-nil values.
        ///
        /// This enables nested contexts to accumulate:
        /// ```swift
        /// .dark {           // atRule = .dark
        ///     .hover { ... }  // atRule = .dark, pseudo = :hover (merged)
        /// }
        /// ```
        ///
        /// - Parameter other: The context to merge with (its values take precedence).
        /// - Returns: A new context with merged values.
        public func merging(with other: Context) -> Context {
            Context(
                atRule: other.atRule ?? self.atRule,
                selector: other.selector ?? self.selector,
                pseudo: combinePseudo(self.pseudo, other.pseudo)
            )
        }

        /// Combines two pseudo-selectors.
        ///
        /// When both contexts have pseudo values, they're combined (e.g., `:hover:focus`).
        /// - Parameters:
        ///   - lhs: The first pseudo value.
        ///   - rhs: The second pseudo value.
        /// - Returns: The combined pseudo value, or the non-nil one if only one exists.
        private func combinePseudo(_ lhs: HTML.Pseudo?, _ rhs: HTML.Pseudo?) -> HTML.Pseudo? {
            switch (lhs, rhs) {
            case (nil, nil): return nil
            case (let p?, nil): return p
            case (nil, let p?): return p
            case (let l?, let r?): return l + r
            }
        }
    }
}
