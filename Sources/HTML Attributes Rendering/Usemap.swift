import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func usemap(
        _ value: HTML.Usemap.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Usemap.Attribute.attribute, value?.description)
    }
}
