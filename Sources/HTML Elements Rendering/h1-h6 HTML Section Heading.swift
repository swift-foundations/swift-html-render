//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.H1 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML.Element.H2 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML.Element.H3 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML.Element.H4 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML.Element.H5 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML.Element.H6 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}
