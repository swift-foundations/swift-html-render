import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func marginWidth(
        _ value: HTML.MarginWidth.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.MarginWidth.Attribute.attribute, value?.description)
    }
}
