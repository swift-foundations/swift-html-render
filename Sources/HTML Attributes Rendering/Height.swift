///
/// Height.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the height attribute on an element
    @discardableResult
    package func height(
        _ value: Height?
    ) -> HTML._Attributes<Self> {
        self.attribute(Height.attribute, value?.description)
    }
}
