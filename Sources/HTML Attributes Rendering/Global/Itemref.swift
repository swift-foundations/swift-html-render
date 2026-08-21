import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func itemref(
        _ id: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemref.Attribute.attribute, id)
    }

    @discardableResult
    public func itemref(
        _ ids: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemref.Attribute.attribute, ids.joined(separator: " "))
    }

    @discardableResult
    public func itemref(
        _ ids: String...
    ) -> HTML._Attributes<Self> {
        self.itemref(ids)
    }

    @discardableResult
    public func itemref(
        _ attribute: HTML.Itemref.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemref.Attribute.attribute, attribute.description)
    }
}
