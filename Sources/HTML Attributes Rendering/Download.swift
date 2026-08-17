//
//  File.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the disableremoteplayback attribute on an element
    @discardableResult
    package func download(
        _ value: HTML.Attribute.Download?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Download.attribute, value?.description)
    }
}
