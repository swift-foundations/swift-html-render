//
//  Integrity.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the integrity attribute on an element
    @discardableResult
    package func integrity(
        _ value: HTML.Integrity.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Integrity.Attribute.attribute, value?.description)
    }
}
