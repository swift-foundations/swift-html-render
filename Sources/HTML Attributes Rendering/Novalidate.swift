///
/// Novalidate.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Add the novalidate attribute to disable browser validation for a form
    package var novalidate: HTML._Attributes<Self> {
        self.attribute(Novalidate.attribute)
    }

    /// Conditionally adds the required attribute to the element
    @HTML.Builder
    package func novalidate(
        _ value: Novalidate?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
