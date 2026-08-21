import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func color(
        _ value: HTML.Color.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Color.Attribute.attribute, value?.description)
    }
}
