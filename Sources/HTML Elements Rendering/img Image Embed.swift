//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.Image: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self)
            .src(self.src)
            .alt(self.alt)
            .loading(self.loading)
    }
}
