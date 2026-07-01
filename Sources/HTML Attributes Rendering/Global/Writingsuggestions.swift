///
/// Writingsuggestions.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the writingsuggestions attribute with a boolean value
    @discardableResult
    public func writingsuggestions(
        _ enabled: Bool
    ) -> HTML._Attributes<Self> {
        self.attribute(Writingsuggestions.attribute, enabled ? "true" : "false")
    }

    /// Sets the writingsuggestions attribute using a Writingsuggestions enum value
    @discardableResult
    public func writingsuggestions(
        _ attribute: Writingsuggestions
    ) -> HTML._Attributes<Self> {
        self.attribute(Writingsuggestions.attribute, attribute.description)
    }

    /// Enables browser-provided writing suggestions
    @discardableResult
    public func enableWritingSuggestions() -> HTML._Attributes<Self> {
        self.writingsuggestions(Writingsuggestions.true)
    }

    /// Disables browser-provided writing suggestions
    @discardableResult
    public func disableWritingSuggestions() -> HTML._Attributes<Self> {
        self.writingsuggestions(Writingsuggestions.false)
    }
}
