import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func preload(
        _ value: HTML.Preload.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Preload.Attribute.attribute, value?.description)
    }
}
