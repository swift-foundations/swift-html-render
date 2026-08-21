import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func low(
        _ value: HTML.Low.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Low.Attribute.attribute, value?.description)
    }
}
