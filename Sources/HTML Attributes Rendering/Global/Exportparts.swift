///
/// Exportparts.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the exportparts attribute with part names to export
    @discardableResult
    public func exportparts(
        _ parts: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(Exportparts.attribute, parts.joined(separator: ", "))
    }

    /// Sets the exportparts attribute with part names to export as variadic parameters
    @discardableResult
    public func exportparts(
        _ parts: String...
    ) -> HTML._Attributes<Self> {
        self.exportparts(parts)
    }

    /// Sets the exportparts attribute with explicit part mappings
    @discardableResult
    public func exportparts(
        _ mappings: [Exportparts.PartMapping]
    ) -> HTML._Attributes<Self> {
        let value = mappings.map { mapping in
            if mapping.originalName == mapping.exposedName {
                return mapping.originalName
            } else {
                return "\(mapping.originalName):\(mapping.exposedName)"
            }
        }.joined(separator: ", ")

        return self.attribute(Exportparts.attribute, value)
    }

    /// Sets the exportparts attribute using an Exportparts struct
    @discardableResult
    public func exportparts(
        _ attribute: Exportparts
    ) -> HTML._Attributes<Self> {
        self.attribute(Exportparts.attribute, attribute.description)
    }
}
