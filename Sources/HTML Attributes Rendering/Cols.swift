import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func cols(
        _ value: HTML.Cols.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Cols.Attribute.attribute, value?.description)
    }
}
