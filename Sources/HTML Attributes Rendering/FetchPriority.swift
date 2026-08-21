import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func fetchPriority(
        _ value: HTML.FetchPriority.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.FetchPriority.Attribute.attribute, value?.description)
    }
}
