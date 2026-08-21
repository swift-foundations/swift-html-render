import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func popoverTarget(
        _ value: HTML.PopoverTarget.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.PopoverTarget.Attribute.attribute, value?.description)
    }
}
