import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func height(
        _ value: HTML.Height.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Height.Attribute.attribute, value?.description)
    }
}
