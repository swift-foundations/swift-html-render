import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func colspan(
        _ value: HTML.ColSpan.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.ColSpan.Attribute.attribute, value?.description)
    }
}
