//
//  HTML.Builder.swift
//
//
//  Created by Point-Free, Inc
//

public import Render_Primitives
public import WHATWG_HTML_Shared

extension Render.Builder {
    /// Creates an empty HTML component when no content is provided.
    public static func buildBlock() -> Render.Empty {
        Render.Empty()
    }
}

extension HTML {
    public typealias Builder = Render.Builder
}
