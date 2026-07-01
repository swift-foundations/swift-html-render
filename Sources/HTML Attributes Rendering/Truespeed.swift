//
//  File 2.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Adds the truespeed attribute to the element
    package var truespeed: HTML._Attributes<Self> {
        self.attribute(Truespeed.attribute)
    }

    /// Conditionally adds the truespeed attribute to the element
    @HTML.Builder
    package func truespeed(
        _ value: Truespeed?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
