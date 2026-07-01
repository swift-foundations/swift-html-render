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
        _ value: For?
    ) -> HTML._Attributes<Self> {
        self.attribute(For.attribute, value?.description)
    }
}
