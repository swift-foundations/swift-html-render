//
//  High.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the high attribute on an element
    @discardableResult
    package func high(
        _ value: HTML.High.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.High.Attribute.attribute, value?.description)
    }
}
