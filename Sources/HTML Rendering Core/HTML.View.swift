//
//  HTML.View.swift
//  swift-html-rendering
//
//  Created by Point-Free, Inc
//

public import Render_Primitives
import Dictionary_Ordered_Primitives
public import WHATWG_HTML_Shared

/// A protocol representing an HTML element or component that can be rendered.
///
/// `HTML.View` refines `Render.View`, enabling the same view tree to render
/// to both HTML and PDF through format-specific `Render.Context` implementations.
/// All rendering goes through the single `_render(_ view:context:)` method.
///
/// Example:
/// ```swift
/// struct MyView: HTML.View {
///     var body: some HTML.View {
///         div {
///             h1 { "Hello, World!" }
///             p { "This is a paragraph." }
///         }
///     }
/// }
/// ```
extension HTML {
    public protocol View: Render.View where Body: HTML.View {
        @HTML.Builder var body: Body { get }
    }
}

/// Extension to add attribute capabilities to all HTML elements.
extension HTML.View {
    /// Adds a custom attribute to an HTML element.
    ///
    /// - Parameters:
    ///   - name: The name of the attribute.
    ///   - value: The optional value of the attribute. If nil, the attribute is omitted.
    ///            If an empty string, the attribute is included without a value.
    /// - Returns: An HTML element with the attribute applied.
    public func attribute(_ name: String, _ value: String? = "") -> HTML._Attributes<Self> {
        var attributes = HTML.Context.Attributes()
        if let value {
            attributes[name] = value
        }
        return HTML._Attributes(content: self, attributes: attributes)
    }
}

/// Provides a default `description` implementation for HTML types that also conform to `CustomStringConvertible`.
extension CustomStringConvertible where Self: HTML.View {
    public var description: String {
        do {
            return try String(self)
        } catch {
            return ""
        }
    }
}
