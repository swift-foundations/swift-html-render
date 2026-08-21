import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func alt(
        _ value: HTML.Alt.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Alt.Attribute.attribute, value?.description)
    }
}
