import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func srcset(
        _ value: HTML.ImageSrcSet.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.ImageSrcSet.Attribute.attribute, value?.description)
    }
}
