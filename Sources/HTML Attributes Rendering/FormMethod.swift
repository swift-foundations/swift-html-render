import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func formMethod(
        _ value: HTML.FormMethod.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.FormMethod.Attribute.attribute, value?.description)
    }
}
