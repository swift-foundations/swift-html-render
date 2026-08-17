//
//  ControlsList.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the controlslist attribute on an element
    @discardableResult
    package func controlsList(
        _ value: HTML.Attribute.ControlsList?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.ControlsList.attribute, value?.description)
    }
}
