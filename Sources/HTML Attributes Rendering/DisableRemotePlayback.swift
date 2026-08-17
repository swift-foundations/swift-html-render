//
//  DisableRemotePlayback.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the disableremoteplayback attribute on an element
    @discardableResult
    package func disableRemotePlayback(
        _ value: HTML.DisableRemotePlayback.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.DisableRemotePlayback.Attribute.attribute, value?.description)
    }
}
