///
/// Spellcheck.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the spellcheck attribute using a Spellcheck enum value
    @discardableResult
    package func spellcheck(
        _ attribute: Spellcheck?
    ) -> HTML._Attributes<Self> {
        self.attribute(Spellcheck.attribute, attribute?.description)
    }
}
