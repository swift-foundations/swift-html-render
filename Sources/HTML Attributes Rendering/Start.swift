//
//  Start.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the start attribute on an element
    @discardableResult
    package func start(
        _ value: HTML.Attribute.Start?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Start.attribute, value?.description)
    }
}
