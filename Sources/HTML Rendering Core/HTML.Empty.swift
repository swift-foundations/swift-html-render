//
//  HTML.Empty.swift
//  swift-html-rendering
//
//  Created by Point-Free, Inc
//

public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    /// A view that produces no output. Alias to `Render.Empty`.
    public typealias Empty = Render.Empty
}

/// Render.Empty already conforms to Render.View (from L1).
/// Add HTML.View conformance so it can appear in HTML builder blocks.
extension Render.Empty: HTML.View {}
