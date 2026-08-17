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
    package func scrolling(
        _ value: HTML.Attribute.Scrolling?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Scrolling.attribute, value?.rawValue)
    }
}
