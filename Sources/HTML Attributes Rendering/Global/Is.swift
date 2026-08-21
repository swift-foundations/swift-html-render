import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func `is`(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Is.Attribute.attribute, HTML.Is.Attribute(value).description)
    }

    @discardableResult
    public func `is`(
        _ value: HTML.Is.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Is.Attribute.attribute, value.description)
    }
}
