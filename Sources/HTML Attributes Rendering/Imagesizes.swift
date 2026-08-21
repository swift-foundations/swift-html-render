import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func sizes(
        _ value: HTML.ImageSizes.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.ImageSizes.Attribute.attribute, value?.description)
    }
}
