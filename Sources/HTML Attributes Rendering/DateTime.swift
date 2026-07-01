//
//  DateTime.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the datetime attribute on an element
    @discardableResult
    package func dateTime(
        _ value: DateTime?
    ) -> HTML._Attributes<Self> {
        self.attribute(DateTime.attribute, value?.description)
    }
}
