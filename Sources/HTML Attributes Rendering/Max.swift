///
/// Max.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the max attribute on an element
    @discardableResult
    package func max(
        _ value: Max?
    ) -> HTML._Attributes<Self> {
        self.attribute(Max.attribute, value?.description)
    }

    //    /// Sets the max attribute with a date value and format
    //    @discardableResult
    //    package func max(
    //        date: Date,
    //        format: Max.DateFormat = .fullDate
    //    ) -> HTML._Attributes<Self> {
    //        self.max(Max(date: date, format: format))
    //    }
}
