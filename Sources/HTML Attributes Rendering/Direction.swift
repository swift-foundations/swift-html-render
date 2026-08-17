//
//  Direction.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the direction attribute on an element
    @discardableResult
    package func direction(
        _ value: WHATWG.HTML.Direction.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG.HTML.Direction.Attribute.attribute, value?.description)
    }
}
