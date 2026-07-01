//
//  Never+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Render_Primitives
public import WHATWG_HTML_Shared

/// Never already conforms to Render.View (from L1).
/// Add HTML.View conformance for the type system.
extension Never: HTML.View {}
