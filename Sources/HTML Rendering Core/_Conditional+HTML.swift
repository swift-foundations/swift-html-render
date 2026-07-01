//
//  _Conditional+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Render_Primitives
public import WHATWG_HTML_Shared

/// Conditional already conforms to Render.View when both branches conform (from L1).
/// Add HTML.View conformance.
extension Render.Conditional: HTML.View where First: HTML.View, Second: HTML.View {}
