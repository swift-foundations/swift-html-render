//
//  RangeReplaceableCollection+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

import Render_Primitives
public import WHATWG_HTML_Shared

extension Array where Element == UInt8 {
    public static var html: HTML.Type {
        HTML.self
    }
}

extension ContiguousArray where Element == UInt8 {
    public static var html: HTML.Type {
        HTML.self
    }
}
