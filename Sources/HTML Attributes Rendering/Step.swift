///
/// Step.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the step attribute on an element
    @discardableResult
    package func step(
        _ value: HTML.Step.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Step.Attribute.attribute, value?.description)
    }
}
