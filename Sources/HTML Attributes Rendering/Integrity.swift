//
//  Integrity.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the integrity attribute on an element
    @discardableResult
    package func integrity(
        _ value: Integrity?
    ) -> HTML._Attributes<Self> {
        self.attribute(Integrity.attribute, value?.description)
    }
}
