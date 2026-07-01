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
    package func src(
        _ value: Src?
    ) -> HTML._Attributes<Self> {
        self.attribute(Src.attribute, value?.description)
    }
}
