///
/// Disabled.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Adds the disabled attribute to the element
    package var disabled: HTML._Attributes<Self> {
        self.attribute(Disabled.attribute)
    }

    /// Conditionally adds the disabled attribute to the element
    @HTML.Builder
    package func disabled(_ value: Disabled?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
