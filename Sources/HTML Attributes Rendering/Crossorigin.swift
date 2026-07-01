///
/// Crossorigin.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func crossorigin(
        _ value: Crossorigin?
    ) -> HTML._Attributes<Self> {
        self.attribute(Crossorigin.attribute, value?.description)
    }

    //    @discardableResult
    //    package func crossorigin(
    //        _ policy: CrosPolicy
    //    ) -> HTML._Attributes<Self> {
    //        self.crossorigin(Crossorigin(policy))
    //    }
}
