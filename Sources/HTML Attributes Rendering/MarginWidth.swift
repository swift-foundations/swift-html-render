///
/// MarginWidth.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func marginWidth(
        _ value: HTML.MarginWidth.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.MarginWidth.Attribute.attribute, value?.description)
    }
}
