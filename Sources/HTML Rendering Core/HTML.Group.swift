//
//  HTML.Group.swift
//  swift-html-rendering
//
//  Created by Point-Free, Inc
//

public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    public typealias Group = Render.Group
}

/// Group already conforms to Render.View when Content conforms (from L1).
/// Add HTML.View conformance.
extension Render.Group: HTML.View where Content: HTML.View {}
