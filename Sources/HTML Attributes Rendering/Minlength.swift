///
/// Minlength.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the minlength attribute on an element
    @discardableResult
    package func minlength(
        _ value: Minlength?
    ) -> HTML._Attributes<Self> {
        self.attribute(Minlength.attribute, value?.description)
    }
}
