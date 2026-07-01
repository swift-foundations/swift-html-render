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
        _ value: Accept?
    ) -> HTML._Attributes<Self> {
        self.attribute(Accept.attribute, value?.description)
    }

    /// Add an accept attribute with multiple file types
    @discardableResult
    package func accept(
        _ fileTypes: Accept.FileType?...
    ) -> HTML._Attributes<Self> {
        self.accept(Accept(fileTypes.compactMap { $0 }))
    }

    /// Add an accept attribute with multiple file types
    @discardableResult
    package func accept(
        _ fileTypes: [Accept.FileType?]
    ) -> HTML._Attributes<Self> {
        self.accept(Accept(fileTypes.compactMap { $0 }))
    }
}
