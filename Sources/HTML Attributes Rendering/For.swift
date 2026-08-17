///
/// For.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the for attribute on an element
    @discardableResult
    package func `for`(
        _ value: HTML.Attribute.For?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.For.attribute, value?.description)
    }
}
