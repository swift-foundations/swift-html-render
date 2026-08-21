import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func xmlns(
        _ value: HTML.Xmlns.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Xmlns.Attribute.attribute, value?.description)
    }
}
