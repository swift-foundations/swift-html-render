///
/// List.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes
private import WHATWG_HTML_FormAttributes

extension HTML.View {

    /// Sets the list attribute on an element
    @discardableResult
    package func list(
        _ value: WHATWG.HTML.Attribute.List?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG.HTML.Attribute.List.attribute, value?.description)
    }
}
