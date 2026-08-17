//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.BR.Element: HTML.View {
    public var body: HTML.Tag.Element<HTML.Empty> {
        HTML.Tag.Element(for: Self.self) { HTML.Empty() }
    }
}
