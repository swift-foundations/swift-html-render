///
/// Nonce.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the nonce attribute using a Nonce struct
    @discardableResult
    public func nonce(
        _ attribute: Nonce?
    ) -> HTML._Attributes<Self> {
        self.attribute(Nonce.attribute, attribute?.description)
    }
}

// extension HTML.View {
//    /// Sets the nonce attribute with a newly generated secure nonce
//    @discardableResult
//    public func nonce() -> HTML._Attributes<Self> {
//        self.nonce(Nonce.generate())
//    }
// }
