//
//  IsMap.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the ismap attribute on an element
    @discardableResult
    package func isMap(
        _ value: Ismap?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
