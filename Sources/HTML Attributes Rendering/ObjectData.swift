import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func data(
        _ value: HTML.ExternalObject.Data.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.ExternalObject.Data.Attribute.attribute, value?.description)
    }
}
