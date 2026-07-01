//
//  Loop.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the loop attribute on an element
    @discardableResult
    package func loop(
        _ value: Loop?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
