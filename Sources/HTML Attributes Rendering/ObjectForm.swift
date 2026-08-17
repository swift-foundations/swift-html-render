//
//  ObjectForm.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the form attribute on an object element
    @discardableResult
    package func form(
        _ value: HTML.Form.Attribute.ID?
    ) -> HTML._Attributes<Self> {
        self.attribute("form", value?.description)
    }
}
