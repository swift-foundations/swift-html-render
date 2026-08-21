import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func step(
        _ value: HTML.Step.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Step.Attribute.attribute, value?.description)
    }
}
