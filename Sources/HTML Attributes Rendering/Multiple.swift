///
/// Multiple.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Adds the multiple attribute to the element
    package var multiple: HTML._Attributes<Self> {
        self.attribute(Multiple.attribute)
    }

    /// Conditionally adds the multiple attribute to the element
    @HTML.Builder
    package func multiple(_ value: Multiple?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
