import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func shadowRootDelegatesFocus(
        _ value: HTML.ShadowRootDelegatesFocus.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.ShadowRootDelegatesFocus.Attribute.attribute, value?.description)
    }
}
