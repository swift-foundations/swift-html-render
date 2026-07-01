//
//  FontSize.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the size attribute on a font element
    @discardableResult
    package func size(
        _ value: FontSize?
    ) -> HTML._Attributes<Self> {
        self.attribute(FontSize.attribute, value?.description)
    }
}
