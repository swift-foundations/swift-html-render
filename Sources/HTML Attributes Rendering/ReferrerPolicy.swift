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
        _ value: ReferrerPolicy?
    ) -> HTML._Attributes<Self> {
        self.attribute(ReferrerPolicy.attribute, value?.description)
    }
}
