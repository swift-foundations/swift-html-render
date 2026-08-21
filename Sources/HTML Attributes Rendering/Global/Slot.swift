import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func slot(
        _ name: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Slot.Attribute.attribute, name)
    }

    @discardableResult
    public func slot(
        _ attribute: HTML.Slot.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Slot.Attribute.attribute, attribute.description)
    }
}
