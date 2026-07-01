//
//  HTML.AnyView.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    /// Type-erased wrapper for any HTML content.
    ///
    /// `HTML.AnyView` allows you to work with heterogeneous HTML types
    /// by erasing their specific type while preserving their rendering behavior.
    // WHY: Category D — structural Sendable workaround.
    // WHY: `any HTML.View` existential blocks structural Sendable inference.
    // WHY: No caller invariant to uphold — data is structurally safe.
    // WHEN TO REMOVE: When compiler gains structural Sendable inference through
    // WHEN TO REMOVE: existential types, or when HTML.View refines Sendable.
    // TRACKING: unsafe-audit-findings.md Category D; SP-5.
    public struct AnyView: HTML.View, @unchecked Sendable {
        public let base: any HTML.View

        public init<T: HTML.View>(_ base: T) {
            self.base = base
        }

        /// Creates a type-erased HTML wrapper from an existential HTML.View.
        public init(_ base: any HTML.View) {
            if let anyView = base as? HTML.AnyView {
                self = anyView
            } else {
                self.base = base
            }
        }

        public typealias Body = Never
        public var body: Never { fatalError() }

        /// Renders by opening the existential and delegating to the concrete type's `_render`.
        public static func _render(
            _ view: borrowing HTML.AnyView, context: inout Render.Context
        ) {
            _openAndRender(view.base, context: &context)
        }

        /// Opens the existential and calls the concrete type's `_render`.
        private static func _openAndRender<V: HTML.View>(
            _ base: V, context: inout Render.Context
        ) {
            V._render(base, context: &context)
        }
    }
}

extension HTML.AnyView {
    /// Creates a type-erased HTML wrapper from a builder closure.
    public init(
        @HTML.Builder _ closure: () -> any HTML.View
    ) {
        self.init(closure())
    }
}
