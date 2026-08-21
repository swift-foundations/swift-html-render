import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func id(
        _ id: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Id.Attribute.attribute, id)
    }

    @discardableResult
    public func id(
        _ id: HTML.Id.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Id.Attribute.attribute, id?.description)
    }
}
