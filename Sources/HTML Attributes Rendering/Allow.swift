//
//  File.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 11/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the allow attribute on an element
    @discardableResult
    package func allow(
        _ value: Allow?
    ) -> HTML._Attributes<Self> {
        self.attribute("allow", value?.description)
    }
}
