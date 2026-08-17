///
/// Size.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the size attribute on an element
    @discardableResult
    package func size(
        _ value: HTML.Attribute.Size?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Size.attribute, value?.description)
    }
}
