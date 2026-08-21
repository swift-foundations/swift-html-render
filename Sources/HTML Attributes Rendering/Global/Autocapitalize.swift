import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func autocapitalize(
        _ value: HTML.Autocapitalize.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Autocapitalize.Attribute.attribute, value?.description)
    }
}
