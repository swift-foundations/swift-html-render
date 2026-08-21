import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func hidden(
        _ hidden: HTML.Hidden.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Hidden.Attribute.attribute)
    }

    @discardableResult
    public func hidden() -> HTML._Attributes<Self> {
        self.attribute(HTML.Hidden.Attribute.attribute)
    }
}
