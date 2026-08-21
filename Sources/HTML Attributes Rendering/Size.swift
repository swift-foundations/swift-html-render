import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func size(
        _ value: HTML.Size.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Size.Attribute.attribute, value?.description)
    }
}
