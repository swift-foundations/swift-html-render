///
/// Autofocus.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    public var autofocus: HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Autofocus.attribute)
    }
}

extension HTML.View {
    @discardableResult
    public func autofocus(
        _ value: HTML.Attribute.Autofocus?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
