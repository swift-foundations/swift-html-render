//
//  Preload.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the preload attribute on an element
    @discardableResult
    package func preload(
        _ value: HTML.Attribute.Preload?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Preload.attribute, value?.description)
    }
}
