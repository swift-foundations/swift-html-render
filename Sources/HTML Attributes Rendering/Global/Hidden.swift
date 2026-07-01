///
/// Hidden.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the hidden attribute with a specific value
    @discardableResult
    public func hidden(
        _ hidden: Hidden
    ) -> HTML._Attributes<Self> {
        self.attribute(Hidden.attribute)
    }

    /// Sets the hidden attribute without a value (equivalent to hidden="")
    @discardableResult
    public func hidden() -> HTML._Attributes<Self> {
        self.attribute(Hidden.attribute)
    }
}
