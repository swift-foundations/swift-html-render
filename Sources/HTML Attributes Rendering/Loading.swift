import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func loading(
        _ value: HTML.Loading.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Loading.Attribute.attribute, value?.rawValue)
    }
}
