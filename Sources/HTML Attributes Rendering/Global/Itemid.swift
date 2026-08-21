import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func itemid(
        _ identifier: String
    ) -> HTML._Attributes<Self> {
        self.attribute(
            HTML.Itemid.Attribute.attribute,
            HTML.Itemid.Attribute(identifier).description
        )
    }

    @discardableResult
    public func itemid(
        _ value: HTML.Itemid.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemid.Attribute.attribute, value.description)
    }
}
