///
/// Checked.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Adds the checked attribute to the element
    package var checked: HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Checked.attribute)
    }

    /// Conditionally adds the checked attribute to the element
    @HTML.Builder
    package func checked(_ value: HTML.Attribute.Checked?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
