//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

protocol HTMLElementNoAttributes: HTML.Element {}

extension HTMLElementNoAttributes {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Tag.Element<Content> {
        HTML.Tag.Element(for: Self.self) { content() }
    }
}
