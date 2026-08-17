//
//  ReferrerPolicy.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the referrerpolicy attribute on an element
    @discardableResult
    package func referrerPolicy(
        _ value: HTML.Attribute.ReferrerPolicy?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.ReferrerPolicy.attribute, value?.description)
    }
}
