import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func frameBorder(
        _ value: HTML.FrameBorder.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.FrameBorder.Attribute.attribute, value?.description)
    }
}
