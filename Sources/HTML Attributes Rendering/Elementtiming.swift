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
        _ value: HTML.Elementtiming.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Elementtiming.Attribute.attribute, value?.description)
    }

    /// Adds element timing with a categorized identifier
    @discardableResult
    package func elementtiming(
        category: HTML.Elementtiming.Attribute.Category,
        name: String,
        separator: String = "-"
    ) -> HTML._Attributes<Self> {
        self.elementtiming(
            HTML.Elementtiming.Attribute(category: category, name: name, separator: separator)
        )
    }
}
