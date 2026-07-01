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
        _ value: Width?
    ) -> HTML._Attributes<Self> {
        self.attribute(Width.attribute, value?.description)
    }
}
