//
//  FormMethod.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the formmethod attribute on an element
    @discardableResult
    package func formMethod(
        _ value: HTML.FormMethod.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.FormMethod.Attribute.attribute, value?.description)
    }
}
