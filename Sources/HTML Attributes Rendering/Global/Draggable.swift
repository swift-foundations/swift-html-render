///
/// Draggable.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets whether an element is draggable
    @discardableResult
    public func draggable(
        _ value: Draggable
    ) -> HTML._Attributes<Self> {
        self.attribute(Draggable.attribute, value.description)
    }

    /// Shorthand to set draggable="true"
    public var draggable: HTML._Attributes<Self> {
        self.draggable(.true)
    }
}
//
