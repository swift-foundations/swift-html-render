//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Source.Element: HTML.View {
    public var body: some HTML.View {
        HTML.Tag.Element(for: Self.self) { HTML.Empty() }
            .type(self.type)
            .src(self.src)
            .srcset(self.srcset)
            .sizes(self.sizes)
            .media(self.media)
            .height(self.height)
            .width(self.width)
    }
}
