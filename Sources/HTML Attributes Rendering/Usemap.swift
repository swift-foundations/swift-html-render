//
//  File 2.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the usemap attribute on an element
    @discardableResult
    package func usemap(
        _ value: HTML.Attribute.Usemap?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Usemap.attribute, value?.description)
    }
}
