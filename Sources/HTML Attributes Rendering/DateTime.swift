import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func dateTime(
        _ value: HTML.DateTime.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.DateTime.Attribute.attribute, value?.description)
    }
}
