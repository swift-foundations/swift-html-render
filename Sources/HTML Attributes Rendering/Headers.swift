import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func headers(
        _ value: HTML.Headers.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Headers.Attribute.attribute, value?.description)
    }
}
