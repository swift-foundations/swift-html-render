import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func action(
        _ value: HTML.Action.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Action.Attribute.attribute, value?.description)
    }
}
