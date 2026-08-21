import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func enterkeyhint(
        _ value: HTML.Enterkeyhint.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Enterkeyhint.Attribute.attribute, value.description)
    }
}
