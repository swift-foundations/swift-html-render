///
/// Autocapitalize.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func autocapitalize(
        _ value: Autocapitalize?
    ) -> HTML._Attributes<Self> {
        self.attribute(Autocapitalize.attribute, value?.description)
    }
}
