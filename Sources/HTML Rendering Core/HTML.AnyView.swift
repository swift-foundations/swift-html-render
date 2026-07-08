//
//  HTML.AnyView.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    // WHY: Category D — structural Sendable workaround.
    // WHY: The render thunk closure is not structurally Sendable-inferable.
    // WHY: No caller invariant to uphold — the thunk only reads immutable state.
    // WHEN TO REMOVE: When the compiler gains structural Sendable inference for
    // WHEN TO REMOVE: stored function values captured from Sendable inputs.
    // TRACKING: unsafe-audit-findings.md Category D; SP-5.
    /// Type-erased wrapper for any HTML content.
    ///
    /// `HTML.AnyView` allows you to work with heterogeneous HTML types
    /// by erasing their specific type while preserving their rendering behavior.
    ///
    /// `HTML.View` refines the move-only `Render.View` (`~Copyable`) and carries a
    /// recursive `Body: HTML.View` constraint. The `any HTML.View` existential of
    /// such a protocol is (a) a design smell — boxing a move-only view into a
    /// Copyable existential forces `@unchecked Sendable` — and (b) a non-canonical
    /// type that the Windows Swift 6.3.3 (+Asserts) debug-info mangler asserts on
    /// (isActuallyCanonicalOrNull, AST/Type.h). The ecosystem therefore composes
    /// through this concrete eraser plus generics and NEVER through `any HTML.View`.
    public struct AnyView: HTML.View, @unchecked Sendable {
        let renderInto: (inout Render.Context) -> Void

        private init(renderInto: @escaping (inout Render.Context) -> Void) {
            self.renderInto = renderInto
        }

        /// Erases a concrete `HTML.View`. Re-wrapping an `AnyView` is idempotent.
        public init<T: HTML.View>(_ base: T) {
            if let anyView = base as? HTML.AnyView {
                self = anyView
            } else {
                self.renderInto = { context in T._render(base, context: &context) }
            }
        }
    }
}

extension HTML.AnyView {
    public typealias Body = Never
    public var body: Never { fatalError("Body is Never and must not be accessed.") }

    /// Renders by replaying the erased view's render thunk.
    public static func _render(
        _ view: borrowing HTML.AnyView,
        context: inout Render.Context
    ) {
        view.renderInto(&context)
    }
}

extension HTML.AnyView {
    /// Creates a type-erased HTML wrapper from a builder closure.
    public init<Content: HTML.View>(@HTML.Builder _ closure: () -> Content) {
        self.init(closure())
    }
}
