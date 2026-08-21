import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func EncType(
        _ value: HTML.EncType.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG.HTML.EncType.Attribute.attribute, value?.description)
    }
}
