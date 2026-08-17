///
/// Accept.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Add an accept attribute to specify which file types are allowed
    @discardableResult
    package func accept(
        _ value: HTML.Accept.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Accept.Attribute.attribute, value?.description)
    }

    /// Add an accept attribute with multiple file types
    @discardableResult
    package func accept(
        _ fileTypes: HTML.Accept.Attribute.FileType?...
    ) -> HTML._Attributes<Self> {
        self.accept(HTML.Accept.Attribute(fileTypes.compactMap { $0 }))
    }

    /// Add an accept attribute with multiple file types
    @discardableResult
    package func accept(
        _ fileTypes: [HTML.Accept.Attribute.FileType?]
    ) -> HTML._Attributes<Self> {
        self.accept(HTML.Accept.Attribute(fileTypes.compactMap { $0 }))
    }
}
