//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.Track: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
            .default(self.default)
            .kind(self.kind)
            .label(self.label)
            .src(self.src)
            .srcLang(self.srclang)
    }
}
