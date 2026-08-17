//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.ExternalObject {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .data(self.data)
            .type(self.type)
            .form(self.form)
            .name(self.name)
            .height(self.height)
            .width(self.width)
            .usemap(self.usemap)
    }
}
