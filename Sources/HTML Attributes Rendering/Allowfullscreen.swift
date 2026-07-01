//
//  Allowfullscreen.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the allowfullscreen attribute on an element
    @discardableResult
    package func allowfullscreen(
        _ value: Allowfullscreen?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
