//
//  Blocking.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the blocking attribute on an element
    @discardableResult
    package func blocking(
        _ value: HTML.Blocking.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Blocking.Attribute.attribute, value?.description)
    }
}
