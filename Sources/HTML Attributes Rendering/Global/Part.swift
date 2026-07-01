///
/// Part.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the part attribute with a single part name
    @discardableResult
    public func part(
        _ partName: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Part.attribute, partName)
    }

    /// Sets the part attribute with multiple part names
    @discardableResult
    public func part(
        _ partNames: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(Part.attribute, partNames.joined(separator: " "))
    }

    /// Sets the part attribute with multiple part names as variadic parameters
    @discardableResult
    public func part(
        _ partNames: String...
    ) -> HTML._Attributes<Self> {
        self.part(partNames)
    }

    /// Sets the part attribute using a Part struct
    @discardableResult
    public func part(
        _ attribute: Part
    ) -> HTML._Attributes<Self> {
        self.attribute(Part.attribute, attribute.description)
    }
}
