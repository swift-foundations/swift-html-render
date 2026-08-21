import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func media(
        _ value: HTML.Media.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Media.Attribute.attribute, value?.description)
    }
}
