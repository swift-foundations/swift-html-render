import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func rowspan(
        _ value: HTML.RowSpan.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.RowSpan.Attribute.attribute, value?.description)
    }
}
