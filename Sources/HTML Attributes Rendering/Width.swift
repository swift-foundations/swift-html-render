///
/// Width.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the width attribute on an element
    @discardableResult
    package func width(
        _ value: HTML.Attribute.Width?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Width.attribute, value?.description)
    }
}
