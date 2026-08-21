import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func autocorrect(
        _ value: HTML.Autocorrect.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Autocorrect.Attribute.attribute, value?.description)
    }
}
