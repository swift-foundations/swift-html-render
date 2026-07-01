//
//  Content.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the content attribute on an element
    @discardableResult
    package func content(
        _ value: HTML_Standard_Attributes.Content?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML_Standard_Attributes.Content.attribute, value?.description)
    }
}
