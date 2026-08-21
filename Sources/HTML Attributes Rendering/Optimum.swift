import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func optimum(
        _ value: HTML.Optimum.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Optimum.Attribute.attribute, value?.description)
    }
}
