import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func form(
        _ value: HTML.Form.Attribute.ID?
    ) -> HTML._Attributes<Self> {
        self.attribute("form", value?.description)
    }
}
