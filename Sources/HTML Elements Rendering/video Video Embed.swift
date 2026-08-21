import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Video.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .src(self.src)
            .controls(self.controls)
            .autoplay(self.autoplay)
            .poster(self.poster)
            .loop(self.loop)
            .muted(self.muted)
            .width(self.width)
            .height(self.height)
            .preload(self.preload)
            .playsinline(self.playsinline)
            .crossorigin(self.crossorigin)
            .controlsList(self.controlslist)
            .disablePictureInPicture(self.disablepictureinpicture)
            .disableRemotePlayback(self.disableremoteplayback)
    }
}
