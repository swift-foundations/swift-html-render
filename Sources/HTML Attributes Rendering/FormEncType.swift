import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func formEncType(
        _ value: HTML.FormEncType.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.FormEncType.Attribute.attribute, value?.description)
    }
}
