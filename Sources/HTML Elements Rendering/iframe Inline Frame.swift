//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.InlineFrame.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .src(self.src)
            .attribute("srcdoc", self.srcdoc)
            .name(self.name)
            .attribute("sandbox", self.sandbox)
            .allowfullscreen(self.allowfullscreen)
            .allow(self.allow)
            .width(self.width)
            .height(self.height)
            .loading(self.loading)
            .referrerPolicy(self.referrerpolicy)
    }
}
