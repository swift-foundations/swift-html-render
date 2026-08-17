///
/// Alt.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the alt attribute on an element
    @discardableResult
    package func alt(
        _ value: HTML.Attribute.Alt?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Alt.attribute, value?.description)
    }
}
