//
//  NoResize.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the noresize attribute on an element
    @discardableResult
    package func noResize(
        _ value: NoResize?
    ) -> HTML._Attributes<Self> {
        self.attribute(NoResize.attribute, value?.description)
    }
}
