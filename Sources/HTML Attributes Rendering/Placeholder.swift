///
/// Placeholder.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the placeholder attribute on an element
    @discardableResult
    package func placeholder(
        _ value: HTML.Placeholder.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Placeholder.Attribute.attribute, value?.description)
    }
}
