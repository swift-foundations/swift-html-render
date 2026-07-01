///
/// Tabindex.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the tabindex attribute with an integer value
    @discardableResult
    public func tabindex(
        _ value: Int
    ) -> HTML._Attributes<Self> {
        self.attribute(Tabindex.attribute, String(value))
    }

    /// Sets the tabindex attribute using a Tabindex struct
    @discardableResult
    public func tabindex(
        _ attribute: Tabindex
    ) -> HTML._Attributes<Self> {
        self.attribute(Tabindex.attribute, attribute.description)
    }

    /// Makes the element not focusable via keyboard but focusable programmatically
    @discardableResult
    public func notTabbable() -> HTML._Attributes<Self> {
        self.tabindex(Tabindex.notTabbable)
    }

    /// Makes the element focusable in the natural document order
    @discardableResult
    public func tabbableInDocumentOrder() -> HTML._Attributes<Self> {
        self.tabindex(Tabindex.inDocumentOrder)
    }
}
