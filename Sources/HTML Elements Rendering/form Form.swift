//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.Form {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .accept(self.accept)
            .acceptCharset(self.acceptCharset)
            .autocapitalize(self.autocapitalize)
            .autocomplete(self.autocomplete)
            .name(self.name)
            .rel(self.rel)
            .action(self.action)
            .EncType(self.enctype)
            .method(self.method)
            .novalidate(self.novalidate)
            .target(self.target)
    }
}
