//
//  String+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import Render_Primitives
public import WHATWG_HTML_Shared

extension String: HTML.View {
    public var body: HTML.Text {
        HTML.Text(self)
    }
}
