import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func srcLang(
        _ value: HTML.SrcLang.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.SrcLang.Attribute.attribute, value?.description)
    }
}
