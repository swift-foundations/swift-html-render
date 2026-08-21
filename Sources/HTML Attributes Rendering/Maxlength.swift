import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func maxlength(
        _ value: HTML.Maxlength.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Maxlength.Attribute.attribute, value?.description)
    }
}
