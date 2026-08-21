import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func cite(
        _ value: HTML.Cite.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Cite.Attribute.attribute, value?.description)
    }
}
