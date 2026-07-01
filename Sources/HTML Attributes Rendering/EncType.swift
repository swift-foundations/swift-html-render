///
/// EncType.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Add an EncType attribute to specify the form data encoding type
    @discardableResult
    package func EncType(
        _ value: EncType?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG_HTML_FormAttributes.EncType.attribute, value?.description)
    }
}
