//
//  Label.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the disablepictureinpicture attribute on an element
    @discardableResult
    @_disfavoredOverload
    package func label(
        _ value: HTML.Attribute.Label?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Label.attribute, value?.description)
    }
}
