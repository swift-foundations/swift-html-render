import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func href(
        _ value: HTML.Href.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Href.Attribute.attribute, value?.description)
    }
}
