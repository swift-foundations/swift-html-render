import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func compact(
        _ value: HTML.Compact.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Compact.Attribute.attribute, value?.description)
    }
}
