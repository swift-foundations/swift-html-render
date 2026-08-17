///
/// Name.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the name attribute on an element
    @discardableResult
    package func name(
        _ value: HTML.Attribute.Name?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Name.attribute, value?.description)
    }
}

extension HTML.View {
    /// Sets the name attribute on an element
    @discardableResult
    package func name(
        _ value: HTML.Attribute.MetaName?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.MetaName.attribute, value?.description)
    }
}
