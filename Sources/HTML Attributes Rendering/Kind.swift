import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func kind(
        _ value: HTML.Kind.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Kind.Attribute.attribute, value?.description)
    }
}
