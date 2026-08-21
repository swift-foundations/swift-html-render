import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func translate(
        _ attribute: HTML.Translate.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Translate.Attribute.attribute, attribute.description)
    }
}
