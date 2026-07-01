//
//  ShadowRootDelegatesFocus.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the shadowrootdelegatesfocus attribute on an element
    @discardableResult
    package func shadowRootDelegatesFocus(
        _ value: ShadowRootDelegatesFocus?
    ) -> HTML._Attributes<Self> {
        self.attribute(ShadowRootDelegatesFocus.attribute, value?.description)
    }
}
