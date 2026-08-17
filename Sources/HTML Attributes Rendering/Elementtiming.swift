///
/// Elementtiming.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func elementtiming(
        _ value: HTML.Attribute.Elementtiming?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Elementtiming.attribute, value?.description)
    }

    /// Adds element timing with a categorized identifier
    @discardableResult
    package func elementtiming(
        category: HTML.Attribute.Elementtiming.Category,
        name: String,
        separator: String = "-"
    ) -> HTML._Attributes<Self> {
        self.elementtiming(
            HTML.Attribute.Elementtiming(category: category, name: name, separator: separator)
        )
    }
}
