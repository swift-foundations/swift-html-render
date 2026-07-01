//
//  ScriptType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the type attribute on a script element
    @discardableResult
    package func type(
        _ value: SourceType?
    ) -> HTML._Attributes<Self> {
        self.attribute(SourceType.attribute, value?.description)
    }
}
