//
//  Loading.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the loading attribute on an element
    @discardableResult
    package func loading(
        _ value: Loading?
    ) -> HTML._Attributes<Self> {
        self.attribute(Loading.attribute, value?.rawValue)
    }
}
