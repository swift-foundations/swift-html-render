///
/// Required.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Adds the required attribute to the element
    package var required: HTML._Attributes<Self> {
        self.attribute(Required.attribute)
    }

    /// Conditionally adds the required attribute to the element
    @HTML.Builder
    package func required(
        _ value: Required?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
