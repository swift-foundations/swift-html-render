//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.Select {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .multiple(self.multiple)
            .name(self.name)
            .required(self.required)
            .size(self.size)
            .disabled(self.disabled)
            .form(self.form)
            .autofocus(self.autofocus)
    }
}
