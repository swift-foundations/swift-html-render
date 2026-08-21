import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func method(
        _ value: HTML.Method.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Method.Attribute.attribute, value?.description)
    }
}
