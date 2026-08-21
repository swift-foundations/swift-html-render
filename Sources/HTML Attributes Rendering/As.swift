import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func `as`(
        _ value: HTML.As.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.As.Attribute.attribute, value?.rawValue)
    }
}
