import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func poster(
        _ value: HTML.Poster.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Poster.Attribute.attribute, value?.description)
    }
}
