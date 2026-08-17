//
//  RowSpan.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the rowspan attribute on an element
    @discardableResult
    package func rowspan(
        _ value: HTML.RowSpan.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.RowSpan.Attribute.attribute, value?.description)
    }
}
