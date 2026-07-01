///
/// Virtualkeyboardpolicy.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the virtualkeyboardpolicy attribute with a policy value
    @discardableResult
    public func virtualkeyboardpolicy(
        _ policy: Virtualkeyboardpolicy
    ) -> HTML._Attributes<Self> {
        self.attribute(Virtualkeyboardpolicy.attribute, policy.description)
    }

    /// Sets the virtualkeyboardpolicy attribute to auto
    @discardableResult
    public func autoKeyboard() -> HTML._Attributes<Self> {
        self.virtualkeyboardpolicy(.auto)
    }

    /// Sets the virtualkeyboardpolicy attribute to manual
    @discardableResult
    public func manualKeyboard() -> HTML._Attributes<Self> {
        self.virtualkeyboardpolicy(.manual)
    }
}
