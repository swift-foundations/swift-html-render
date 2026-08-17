//
//  Scope.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the scope attribute on an element
    @discardableResult
    package func scope(
        _ value: HTML.Attribute.Scope?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Scope.attribute, value?.description)
    }
}
