//
//  Poster.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the poster attribute on an element
    @discardableResult
    package func poster(
        _ value: Poster?
    ) -> HTML._Attributes<Self> {
        self.attribute(Poster.attribute, value?.description)
    }
}
