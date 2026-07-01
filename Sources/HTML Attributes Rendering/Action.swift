///
/// Action.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Add an action attribute to specify the URL for form submission
    @discardableResult
    public func action(
        _ value: Action?
    ) -> HTML._Attributes<Self> {
        self.attribute(Action.attribute, value?.description)
    }
}

// extension HTML.View {
//    /// Add an action attribute with a URL object
//    @discardableResult
//    public func action(
//        _ url: URL
//    ) -> HTML._Attributes<Self> {
//        self.action(.init(url))
//    }
// }
