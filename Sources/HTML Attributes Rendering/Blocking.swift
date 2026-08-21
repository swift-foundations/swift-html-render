import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func blocking(
        _ value: HTML.Blocking.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Blocking.Attribute.attribute, value?.description)
    }
}
