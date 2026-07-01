//
//  Async.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

private import WHATWG_HTML_ScriptAttributes

extension HTML.View {

    /// Sets the async attribute on an element
    @discardableResult
    package func async(
        _ value: WHATWG_HTML_ScriptAttributes.Async?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
