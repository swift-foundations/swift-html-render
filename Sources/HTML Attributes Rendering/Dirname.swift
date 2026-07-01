///
/// Dirname.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    package func dirname(
        _ value: Dirname?
    ) -> HTML._Attributes<Self> {
        self.attribute(Dirname.attribute, value?.description)
    }
}
