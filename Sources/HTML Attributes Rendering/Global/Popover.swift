import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func popover() -> HTML._Attributes<Self> {
        self.attribute(HTML.Popover.Attribute.attribute, "")
    }

    @discardableResult
    public func popover(
        _ type: HTML.Popover.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Popover.Attribute.attribute, type.description)
    }

    @discardableResult
    public func popover(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Popover.Attribute.attribute, value)
    }
}

extension HTML.View {

    @discardableResult
    public func popovertarget(
        _ id: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.PopoverTarget.Attribute.attribute, id)
    }

    @discardableResult
    public func popovertarget(
        _ attribute: HTML.PopoverTarget.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.PopoverTarget.Attribute.attribute, attribute?.description)
    }
}

extension HTML.View {

    @discardableResult
    public func popovertargetaction(
        _ action: HTML.PopoverTargetAction.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.PopoverTargetAction.Attribute.attribute, action?.description)
    }
}
