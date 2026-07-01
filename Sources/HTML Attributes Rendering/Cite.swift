//
//  Cite.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the cite attribute on an element
    @discardableResult
    package func cite(
        _ value: HTML_Standard_Attributes.Cite?
    ) -> HTML._Attributes<Self> {
        self.attribute(Cite.attribute, value?.description)
    }
}
