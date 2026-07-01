///
/// Alt.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the alt attribute on an element
    @discardableResult
    package func alt(
        _ value: Alt?
    ) -> HTML._Attributes<Self> {
        self.attribute(Alt.attribute, value?.description)
    }
}
