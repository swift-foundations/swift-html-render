import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Meta.Element: HTML.View {
    public var body: some HTML.View {
        HTML.Tag.Element(for: Self.self) { HTML.Empty() }
            .charset(self.charset)
            .content(self.content)
            .httpEquiv(self.httpEquiv)
            .media(self.media)
            .name(self.name)
    }
}
