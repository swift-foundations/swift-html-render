import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func exportparts(
        _ parts: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Exportparts.Attribute.attribute, parts.joined(separator: ", "))
    }

    @discardableResult
    public func exportparts(
        _ parts: String...
    ) -> HTML._Attributes<Self> {
        self.exportparts(parts)
    }

    @discardableResult
    public func exportparts(
        _ mappings: [HTML.Exportparts.Attribute.PartMapping]
    ) -> HTML._Attributes<Self> {
        let value = mappings.map { mapping in
            if mapping.originalName == mapping.exposedName {
                return mapping.originalName
            } else {
                return "\(mapping.originalName):\(mapping.exposedName)"
            }
        }.joined(separator: ", ")

        return self.attribute(HTML.Exportparts.Attribute.attribute, value)
    }

    @discardableResult
    public func exportparts(
        _ attribute: HTML.Exportparts.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Exportparts.Attribute.attribute, attribute.description)
    }
}
