import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func tabindex(
        _ value: Int
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Tabindex.Attribute.attribute, String(value))
    }

    @discardableResult
    public func tabindex(
        _ attribute: HTML.Tabindex.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Tabindex.Attribute.attribute, attribute.description)
    }

    @discardableResult
    public func notTabbable() -> HTML._Attributes<Self> {
        self.tabindex(HTML.Tabindex.Attribute.notTabbable)
    }

    @discardableResult
    public func tabbableInDocumentOrder() -> HTML._Attributes<Self> {
        self.tabindex(HTML.Tabindex.Attribute.inDocumentOrder)
    }
}
