//
//  Optimum.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the optimum attribute on an element
    @discardableResult
    package func optimum(
        _ value: HTML.Optimum.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Optimum.Attribute.attribute, value?.description)
    }
}
