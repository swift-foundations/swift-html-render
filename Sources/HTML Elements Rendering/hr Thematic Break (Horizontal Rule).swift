//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.ThematicBreak: HTML.View {
    public var body: HTML.Element.Tag<HTML.Empty> {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
    }
}
