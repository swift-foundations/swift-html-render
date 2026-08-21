import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Embed.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .src(self.src)
            .type(self.type)
            .height(self.height)
            .width(self.width)
    }
}
