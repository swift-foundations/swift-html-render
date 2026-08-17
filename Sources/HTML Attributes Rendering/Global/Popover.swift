///
/// Popover.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the popover attribute as a boolean (equivalent to popover="auto")
    @discardableResult
    public func popover() -> HTML._Attributes<Self> {
        self.attribute(HTML.Popover.Attribute.attribute, "")
    }

    /// Sets the popover attribute with a specific type
    @discardableResult
    public func popover(
        _ type: HTML.Popover.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Popover.Attribute.attribute, type.description)
    }

    /// Sets the popover attribute with a value
    @discardableResult
    public func popover(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Popover.Attribute.attribute, value)
    }
}

extension HTML.View {
    /// Sets the popovertarget attribute with the ID of the target popover
    @discardableResult
    public func popovertarget(
        _ id: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.PopoverTarget.Attribute.attribute, id)
    }

    /// Sets the popovertarget attribute using a PopoverTarget struct
    @discardableResult
    public func popovertarget(
        _ attribute: HTML.PopoverTarget.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.PopoverTarget.Attribute.attribute, attribute?.description)
    }
}

extension HTML.View {
    /// Sets the popovertargetaction attribute with an action
    @discardableResult
    public func popovertargetaction(
        _ action: HTML.PopoverTargetAction.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.PopoverTargetAction.Attribute.attribute, action?.description)
    }
}
