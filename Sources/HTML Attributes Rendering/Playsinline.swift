import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func playsinline(
        _ value: HTML.Playsinline.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Playsinline.Attribute.attribute, value?.description)
    }
}
