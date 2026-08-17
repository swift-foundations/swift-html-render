//
//  Rows.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the rows attribute on an element
    @discardableResult
    package func rows(
        _ value: HTML.Rows.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Rows.Attribute.attribute, value?.description)
    }
}
