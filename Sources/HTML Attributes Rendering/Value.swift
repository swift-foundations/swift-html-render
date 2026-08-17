///
/// Value.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the value attribute on an element
    @discardableResult
    package func value<Element: CustomStringConvertible>(
        _ value: HTML.Value.Attribute<Element>?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Value.Attribute<Element>.attribute, value?.description)
    }
}
