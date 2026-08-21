import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func max(
        _ value: HTML.Max.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Max.Attribute.attribute, value?.description)
    }

}
