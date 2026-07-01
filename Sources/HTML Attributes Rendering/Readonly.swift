///
/// Readonly.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Adds the readonly attribute to the element
    package var readonly: HTML._Attributes<Self> {
        self.attribute(Readonly.attribute)
    }

    /// Conditionally adds the readonly attribute to the element
    @HTML.Builder
    package func readonly(
        _ value: Readonly?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
