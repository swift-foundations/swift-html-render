import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func formAction(
        _ value: HTML.FormAction.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.FormAction.Attribute.attribute, value?.description)
    }
}
