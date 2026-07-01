//
//  Optional+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Render_Primitives
public import WHATWG_HTML_Shared

/// Optional already conforms to Render.View when Wrapped conforms (from L1).
/// Add HTML.View conformance.
extension Optional: HTML.View where Wrapped: HTML.View {}
