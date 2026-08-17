//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Image.Element: HTML.View {
    public var body: some HTML.View {
        HTML.Tag.Element(for: Self.self)
            .src(self.src)
            .alt(self.alt)
            .loading(self.loading)
    }
}
