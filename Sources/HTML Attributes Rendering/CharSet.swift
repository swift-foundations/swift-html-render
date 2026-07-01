//
//  CharSet.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the charset attribute on an element
    @discardableResult
    package func charset(
        _ value: CharSet?
    ) -> HTML._Attributes<Self> {
        self.attribute("charset", value?.description)
    }
}
