//
//  PopoverTarget.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the popovertarget attribute on an element
    @discardableResult
    package func popoverTarget(
        _ value: PopoverTarget?
    ) -> HTML._Attributes<Self> {
        self.attribute(PopoverTarget.attribute, value?.description)
    }
}
