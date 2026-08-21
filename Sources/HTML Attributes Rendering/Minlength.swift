import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func minlength(
        _ value: HTML.Minlength.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Minlength.Attribute.attribute, value?.description)
    }
}
