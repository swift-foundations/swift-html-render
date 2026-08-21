import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func allow(
        _ value: HTML.Allow.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute("allow", value?.description)
    }
}
