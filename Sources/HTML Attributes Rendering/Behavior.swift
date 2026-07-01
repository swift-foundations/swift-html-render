//
//  Behavior.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the behavior attribute on an element
    @discardableResult
    package func behavior(
        _ value: Behavior?
    ) -> HTML._Attributes<Self> {
        self.attribute(Behavior.attribute, value?.description)
    }
}
