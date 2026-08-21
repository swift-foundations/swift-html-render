import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func part(
        _ partName: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Part.Attribute.attribute, partName)
    }

    @discardableResult
    public func part(
        _ partNames: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Part.Attribute.attribute, partNames.joined(separator: " "))
    }

    @discardableResult
    public func part(
        _ partNames: String...
    ) -> HTML._Attributes<Self> {
        self.part(partNames)
    }

    @discardableResult
    public func part(
        _ attribute: HTML.Part.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Part.Attribute.attribute, attribute.description)
    }
}
