import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func behavior(
        _ value: HTML.Behavior.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Behavior.Attribute.attribute, value?.description)
    }
}
