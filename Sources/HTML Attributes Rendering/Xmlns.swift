//
//  File 3.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the xmlns attribute on an element
    @discardableResult
    package func xmlns(
        _ value: Xmlns?
    ) -> HTML._Attributes<Self> {
        self.attribute(Xmlns.attribute, value?.description)
    }
}
