import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func shadowRootMode(
        _ value: HTML.ShadowRootMode.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.ShadowRootMode.Attribute.attribute, value?.description)
    }
}
