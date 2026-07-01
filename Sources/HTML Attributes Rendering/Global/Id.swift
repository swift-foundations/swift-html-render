///
/// Id.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the ID attribute for an HTML element
    @discardableResult
    public func id(
        _ id: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Id.attribute, id)
    }

    /// Sets the ID attribute using an Id struct
    @discardableResult
    public func id(
        _ id: Id?
    ) -> HTML._Attributes<Self> {
        self.attribute(Id.attribute, id?.description)
    }
}
