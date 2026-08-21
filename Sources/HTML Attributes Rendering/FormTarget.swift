import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func formTarget(
        _ value: HTML.FormTarget.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.FormTarget.Attribute.attribute, value?.description)
    }
}
