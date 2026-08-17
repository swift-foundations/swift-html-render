//
//  ObjectData.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the data attribute on an object element
    @discardableResult
    package func data(
        _ value: HTML.ExternalObject.Data.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.ExternalObject.Data.Attribute.attribute, value?.description)
    }
}
