import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func controlsList(
        _ value: HTML.ControlsList.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.ControlsList.Attribute.attribute, value?.description)
    }
}
