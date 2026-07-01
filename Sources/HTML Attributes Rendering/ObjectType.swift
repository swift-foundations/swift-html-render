//
//  ObjectType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the type attribute on an object element
    @discardableResult
    package func type(
        _ value: ObjectType?
    ) -> HTML._Attributes<Self> {
        self.attribute(ObjectType.attribute, value?.description)
    }
}
