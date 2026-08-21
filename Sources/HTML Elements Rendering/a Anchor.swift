import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension WHATWG.HTML.Anchor.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .attributionSrc(self.attributionsrc)
            .download(self.download)
            .href(self.href)
            .hreflang(self.hreflang)
            .ping(self.ping)
            .referrerPolicy(self.referrerpolicy)
            .rel(self.rel)
            .target(self.target)
    }
}
