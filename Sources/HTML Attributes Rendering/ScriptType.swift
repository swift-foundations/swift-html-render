//
//  ScriptType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the type attribute on a script element
    @discardableResult
    package func type(
        _ value: HTML.Script.`Type`.Attribute?
    ) -> HTML._Attributes<Self> {
        typealias Value = HTML.Script.`Type`.Attribute
        return self.attribute(Value.attribute, value?.description)
    }
}
