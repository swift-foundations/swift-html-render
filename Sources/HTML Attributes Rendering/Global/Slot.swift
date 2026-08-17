///
/// Slot.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the slot attribute with a slot name
    @discardableResult
    public func slot(
        _ name: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Slot.Attribute.attribute, name)
    }

    /// Sets the slot attribute using a Slot struct
    @discardableResult
    public func slot(
        _ attribute: HTML.Slot.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Slot.Attribute.attribute, attribute.description)
    }
}
