import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func rows(
        _ value: HTML.Rows.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Rows.Attribute.attribute, value?.description)
    }
}
