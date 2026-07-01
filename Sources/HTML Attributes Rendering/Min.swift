///
/// Min.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the min attribute on an element
    @discardableResult
    package func min(
        _ value: Min?
    ) -> HTML._Attributes<Self> {
        self.attribute(Min.attribute, value?.description)
    }
}

// extension HTML.View {
//    /// Sets the min attribute with a date value and format
//    @discardableResult
//    package func min(
//        date: Date,
//        format: Min.DateFormat = .fullDate
//    ) -> HTML._Attributes<Self> {
//        self.min(Min(date: date, format: format))
//    }
// }
