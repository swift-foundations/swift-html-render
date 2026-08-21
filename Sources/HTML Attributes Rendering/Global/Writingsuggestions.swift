import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func writingsuggestions(
        _ enabled: Bool
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Writingsuggestions.Attribute.attribute, enabled ? "true" : "false")
    }

    @discardableResult
    public func writingsuggestions(
        _ attribute: HTML.Writingsuggestions.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Writingsuggestions.Attribute.attribute, attribute.description)
    }

    @discardableResult
    public func enableWritingSuggestions() -> HTML._Attributes<Self> {
        self.writingsuggestions(HTML.Writingsuggestions.Attribute.true)
    }

    @discardableResult
    public func disableWritingSuggestions() -> HTML._Attributes<Self> {
        self.writingsuggestions(HTML.Writingsuggestions.Attribute.false)
    }
}
