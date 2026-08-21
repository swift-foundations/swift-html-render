import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func width(
        _ value: HTML.Width.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Width.Attribute.attribute, value?.description)
    }
}
