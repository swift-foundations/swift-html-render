//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @HTML.Builder
    package func attribute(
        _ value: String,
        _ condition: @autoclosure () -> Bool?
    ) -> some HTML.View {
        let conditionResult = condition()
        if conditionResult == true {
            self.attribute(value, "")
        } else {
            self.attribute("", String?.none)
        }
    }

    @HTML.Builder
    package func attribute<Attribute: HTML.BooleanAttribute>(
        boolean value: Attribute?
    ) -> some HTML.View {
        self.attribute(Attribute.attribute, value == true)
    }
}

extension HTML._Attributes {
    package func attribute(
        _ name: String,
        _ value: (some CustomStringConvertible)? = ""
    ) -> HTML._Attributes<Content> {
        self.attribute(name, value?.description)
    }
}
