//
//  _Tuple+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Render_Primitives
public import WHATWG_HTML_Shared

/// _Tuple already conforms to Render.View when all elements conform to Render.View (from L1).
/// Add HTML.View conformance so it works in HTML builder blocks.
extension Render._Tuple: HTML.View where repeat each Content: HTML.View {}
