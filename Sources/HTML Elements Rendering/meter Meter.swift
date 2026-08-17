//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.Meter {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .value(self.value)
            .min(self.min)
            .max(self.max)
            .low(self.low)
            .high(self.high)
            .optimum(self.optimum)
            .form(self.form)
    }
}
