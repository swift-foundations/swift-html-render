//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the step attribute on an element
    @discardableResult
    package func srcLang(
        _ value: HTML.Attribute.SrcLang?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.SrcLang.attribute, value?.description)
    }
}
