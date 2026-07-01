///
/// Inputmode.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the inputmode attribute to hint at what type of virtual keyboard to display
    @discardableResult
    public func inputmode(
        _ mode: Inputmode?
    ) -> HTML._Attributes<Self> {
        self.attribute(Inputmode.attribute, mode?.description)
    }
}
