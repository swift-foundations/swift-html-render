//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Add an href attribute to specify a hyperlink destination
    @discardableResult
    public func href(
        _ value: HTML.Href.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Href.Attribute.attribute, value?.description)
    }
}
