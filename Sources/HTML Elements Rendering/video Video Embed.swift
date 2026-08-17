//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.Video {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
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
