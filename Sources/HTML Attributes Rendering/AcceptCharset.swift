import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func acceptCharset(
        _ value: HTML.AcceptCharset.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.AcceptCharset.Attribute.attribute, value?.description)
    }
}
