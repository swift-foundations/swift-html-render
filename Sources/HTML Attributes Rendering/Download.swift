import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func download(
        _ value: HTML.Download.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Download.Attribute.attribute, value?.description)
    }
}
