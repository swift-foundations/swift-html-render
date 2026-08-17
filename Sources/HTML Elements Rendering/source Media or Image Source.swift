//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.Source: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
            .type(self.type)
            .src(self.src)
            .srcset(self.srcset)
            .sizes(self.sizes)
            .media(self.media)
            .height(self.height)
            .width(self.width)
    }
}
