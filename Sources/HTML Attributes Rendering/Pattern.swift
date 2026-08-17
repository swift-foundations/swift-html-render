///
/// Pattern.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the pattern attribute on an element
    @discardableResult
    package func pattern(
        _ value: HTML.Pattern.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Pattern.Attribute.attribute, value?.description)
    }
}
