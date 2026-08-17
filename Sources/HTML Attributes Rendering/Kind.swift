//
//  Kind.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the kind attribute on an element
    @discardableResult
    package func kind(
        _ value: HTML.Attribute.Kind?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Kind.attribute, value?.description)
    }
}
