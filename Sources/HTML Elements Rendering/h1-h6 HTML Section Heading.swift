import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.H1.Element {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Tag.Element<Content> {
        HTML.Tag.Element(for: Self.self) { content() }
    }
}

extension HTML.H2.Element {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Tag.Element<Content> {
        HTML.Tag.Element(for: Self.self) { content() }
    }
}

extension HTML.H3.Element {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Tag.Element<Content> {
        HTML.Tag.Element(for: Self.self) { content() }
    }
}

extension HTML.H4.Element {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Tag.Element<Content> {
        HTML.Tag.Element(for: Self.self) { content() }
    }
}

extension HTML.H5.Element {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Tag.Element<Content> {
        HTML.Tag.Element(for: Self.self) { content() }
    }
}

extension HTML.H6.Element {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Tag.Element<Content> {
        HTML.Tag.Element(for: Self.self) { content() }
    }
}
