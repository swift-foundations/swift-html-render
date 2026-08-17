//
//  Headers.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the headers attribute on an element
    @discardableResult
    package func headers(
        _ value: HTML.Headers.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Headers.Attribute.attribute, value?.description)
    }
}
