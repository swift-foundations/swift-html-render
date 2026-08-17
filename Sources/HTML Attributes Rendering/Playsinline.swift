//
//  Playsinline.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the playsinline attribute on an element
    @discardableResult
    package func playsinline(
        _ value: HTML.Attribute.Playsinline?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Playsinline.attribute, value?.description)
    }
}
