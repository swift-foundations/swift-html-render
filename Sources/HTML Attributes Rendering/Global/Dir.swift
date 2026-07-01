///
/// Dir.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the text direction for an HTML element
    @discardableResult
    public func dir(
        _ value: Dir
    ) -> HTML._Attributes<Self> {
        self.attribute(Dir.attribute, value.description)
    }
}
