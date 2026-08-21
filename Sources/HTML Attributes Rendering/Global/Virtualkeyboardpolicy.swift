import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func virtualkeyboardpolicy(
        _ policy: HTML.Virtualkeyboardpolicy.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Virtualkeyboardpolicy.Attribute.attribute, policy.description)
    }

    @discardableResult
    public func autoKeyboard() -> HTML._Attributes<Self> {
        self.virtualkeyboardpolicy(.auto)
    }

    @discardableResult
    public func manualKeyboard() -> HTML._Attributes<Self> {
        self.virtualkeyboardpolicy(.manual)
    }
}
