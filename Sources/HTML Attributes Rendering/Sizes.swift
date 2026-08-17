//
//  Sizes.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the sizes attribute on an element
    @discardableResult
    package func sizes(
        _ value: HTML.Attribute.Sizes?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Sizes.attribute, value?.description)
    }
}
