import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func `class`(
        _ value: HTML.Class.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Class.Attribute.attribute, value?.description)
    }
}
