import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func rel(
        _ value: HTML.Rel.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Rel.Attribute.attribute, value?.description)
    }
}
