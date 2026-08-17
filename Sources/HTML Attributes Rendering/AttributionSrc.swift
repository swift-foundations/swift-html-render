//
//  AttributionSrc.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the attributionsrc attribute on an element
    @discardableResult
    package func attributionSrc(
        _ value: HTML.AttributionSrc.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.AttributionSrc.Attribute.attribute, value?.description)
    }
}
