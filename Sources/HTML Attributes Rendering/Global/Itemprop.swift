///
/// Itemprop.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the itemprop attribute with a property name
    @discardableResult
    public func itemprop(
        _ propertyName: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemprop.Attribute.attribute, propertyName)
    }

    /// Sets the itemprop attribute with multiple property names
    @discardableResult
    public func itemprop(
        _ propertyNames: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemprop.Attribute.attribute, propertyNames.joined(separator: " "))
    }

    /// Sets the itemprop attribute with multiple property names as variadic parameters
    @discardableResult
    public func itemprop(
        _ propertyNames: String...
    ) -> HTML._Attributes<Self> {
        self.itemprop(propertyNames)
    }

    /// Sets the itemprop attribute using an Itemprop struct
    @discardableResult
    public func itemprop(
        _ attribute: HTML.Itemprop.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemprop.Attribute.attribute, attribute.description)
    }
}
