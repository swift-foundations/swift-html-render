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
        _ value: HTML.Attribute.Class?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Attribute.Class.attribute, value?.description)
    }
}

// extension HTML.View {
//    @discardableResult
//    public func `class`(
//        _ value: [HTML.Attribute.Class?]
//    ) -> HTML._Attributes<Self> {
//        self.attribute(HTML.Attribute.Class.attribute, HTML.Attribute.Class(value.compactMap{ $0 }.map(\.description)).description)
//    }
//
//    @discardableResult
//    public func `class`(
//        _ value: HTML.Attribute.Class?...
//    ) -> HTML._Attributes<Self> {
//        self.attribute(HTML.Attribute.Class.attribute, HTML.Attribute.Class(value.compactMap{ $0 }.map(\.description)).description)
//    }
// }
