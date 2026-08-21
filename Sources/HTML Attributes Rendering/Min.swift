import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func min(
        _ value: HTML.Min.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Min.Attribute.attribute, value?.description)
    }
}
