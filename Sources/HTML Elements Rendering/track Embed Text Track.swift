import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Track.Element: HTML.View {
    public var body: some HTML.View {
        HTML.Tag.Element(for: Self.self) { HTML.Empty() }
            .default(self.default)
            .kind(self.kind)
            .label(self.label)
            .src(self.src)
            .srcLang(self.srclang)
    }
}
