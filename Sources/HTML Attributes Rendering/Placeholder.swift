import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func placeholder(
        _ value: HTML.Placeholder.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Placeholder.Attribute.attribute, value?.description)
    }
}
