import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func src(
        _ value: HTML.Src.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Src.Attribute.attribute, value?.description)
    }
}
