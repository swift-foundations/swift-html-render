//
//  Ping.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the ping attribute on an element
    @discardableResult
    package func ping(
        _ value: HTML.Ping.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Ping.Attribute.attribute, value?.description)
    }
}
