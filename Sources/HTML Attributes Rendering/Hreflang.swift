//
//  Hreflang.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the hreflang attribute on an element
    @discardableResult
    package func hreflang(
        _ value: HTML.Hreflang.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Hreflang.Attribute.attribute, value?.description)
    }
}
