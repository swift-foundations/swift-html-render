import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func high(
        _ value: HTML.High.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.High.Attribute.attribute, value?.description)
    }
}
