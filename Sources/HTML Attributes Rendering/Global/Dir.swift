import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func dir(
        _ value: HTML.Dir.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Dir.Attribute.attribute, value.description)
    }
}
