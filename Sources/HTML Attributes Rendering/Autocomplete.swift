///
/// Autocomplete.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func autocomplete(
        _ value: HTML.Autocomplete.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Autocomplete.Attribute.attribute, value?.description)
    }
}
