import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func itemtype(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemtype.Attribute.attribute, value)
    }

    @discardableResult
    public func itemtype(
        _ values: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemtype.Attribute.attribute, values.joined(separator: " "))
    }

    @discardableResult
    public func itemtype(
        _ values: String...
    ) -> HTML._Attributes<Self> {
        self.itemtype(values)
    }

    @discardableResult
    public func itemtype(
        _ attribute: HTML.Itemtype.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemtype.Attribute.attribute, attribute.description)
    }

    @discardableResult
    public func itemtype(
        schemaOrg type: String
    ) -> HTML._Attributes<Self> {
        self.itemtype(HTML.Itemtype.Attribute(schemaOrg: type))
    }
}
