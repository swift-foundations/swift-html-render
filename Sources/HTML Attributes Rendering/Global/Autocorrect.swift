///
/// Autocorrect.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func autocorrect(
        _ value: HTML.Autocorrect.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Autocorrect.Attribute.attribute, value?.description)
    }
}
