import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Legend.Element {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Tag.Element<Content> {
        HTML.Tag.Element(for: Self.self) { content() }
    }
}
