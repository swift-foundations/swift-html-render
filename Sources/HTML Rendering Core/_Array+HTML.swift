//
//  _Array+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Render_Primitives
public import WHATWG_HTML_Shared

/// Array already conforms to Render.View when Element conforms (from L1).
/// Add HTML.View conformance.
extension Array: HTML.View where Element: HTML.View {}
