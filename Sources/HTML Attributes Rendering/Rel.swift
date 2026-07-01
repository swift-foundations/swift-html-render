///
/// Rel.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the rel attribute on an element
    @discardableResult
    package func rel(
        _ value: Rel?
    ) -> HTML._Attributes<Self> {
        self.attribute(Rel.attribute, value?.description)
    }
}

// extension HTML.View {
//    /// Sets the rel attribute with multiple link type values
//    @discardableResult
//    package func rel(
//        _ values: Rel.LinkType...
//    ) -> HTML._Attributes<Self> {
//        self.rel(Rel(values))
//    }
// }
