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
        _ value: Name?
    ) -> HTML._Attributes<Self> {
        self.attribute(Name.attribute, value?.description)
    }
}

extension HTML.View {
    /// Sets the name attribute on an element
    @discardableResult
    package func name(
        _ value: MetaName?
    ) -> HTML._Attributes<Self> {
        self.attribute(MetaName.attribute, value?.description)
    }
}
