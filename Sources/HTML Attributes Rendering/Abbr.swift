//
//  ColSpan.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the colspan attribute on an element
    @discardableResult
    package func abbr(
        _ value: HTML.Abbr.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Abbr.Attribute.attribute, value?.description)
    }
}
