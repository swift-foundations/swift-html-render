import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func pattern(
        _ value: HTML.Pattern.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Pattern.Attribute.attribute, value?.description)
    }
}
