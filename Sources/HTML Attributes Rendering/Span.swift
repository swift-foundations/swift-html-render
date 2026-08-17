//
//  Span.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes
import WHATWG_HTML_TableAttributes

extension HTML.View {

    /// Sets the span attribute on an element
    @discardableResult
    package func span(
        _ value: WHATWG.HTML.Span.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG.HTML.Span.Attribute.attribute, value?.description)
    }
}
