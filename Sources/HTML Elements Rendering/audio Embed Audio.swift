import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Audio.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .src(self.src)
            .controls(self.controls)
            .autoplay(self.autoplay)
            .loop(self.loop)
            .muted(self.muted)

            .crossorigin(self.crossorigin)

            .disableRemotePlayback(self.disableremoteplayback)
    }
}
