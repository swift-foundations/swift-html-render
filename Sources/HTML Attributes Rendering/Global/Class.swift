///
/// Class.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func `class`(
        _ value: HTML.Class.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Class.Attribute.attribute, value?.description)
    }
}

// extension HTML.View {
//    @discardableResult
//    public func `class`(
//        _ value: [HTML.Class.Attribute?]
//    ) -> HTML._Attributes<Self> {
//        self.attribute(HTML.Class.Attribute.attribute, HTML.Class.Attribute(value.compactMap{ $0 }.map(\.description)).description)
//    }
//
//    @discardableResult
//    public func `class`(
//        _ value: HTML.Class.Attribute?...
//    ) -> HTML._Attributes<Self> {
//        self.attribute(HTML.Class.Attribute.attribute, HTML.Class.Attribute(value.compactMap{ $0 }.map(\.description)).description)
//    }
// }
