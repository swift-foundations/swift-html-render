///
/// Method.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Add a method attribute to specify the HTTP method for form submission
    @discardableResult
    package func method(
        _ value: HTML.Attribute.Method?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Method.attribute, value?.description)
    }
}
