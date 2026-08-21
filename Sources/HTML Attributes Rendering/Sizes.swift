import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func sizes(
        _ value: HTML.Sizes.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Sizes.Attribute.attribute, value?.description)
    }
}
