import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    @_disfavoredOverload
    package func label(
        _ value: HTML.Label.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Label.Attribute.attribute, value?.description)
    }
}
