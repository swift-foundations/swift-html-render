///
/// Title.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the title attribute with text
    @discardableResult
    public func title(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Title.attribute, value)
    }

    /// Sets the title attribute with multiline text
    @discardableResult
    public func title(
        lines: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(Title.attribute, lines.joined(separator: "\n"))
    }

    /// Sets the title attribute with multiline text as variadic parameters
    @discardableResult
    public func title(
        lines: String...
    ) -> HTML._Attributes<Self> {
        self.title(lines: lines)
    }

    /// Sets the title attribute using a Title struct
    @discardableResult
    public func title(
        _ attribute: HTML_Standard_Attributes.Title?
    ) -> HTML._Attributes<Self> {
        self.attribute(Title.attribute, attribute?.description)
    }

    /// Sets an empty title to prevent inheriting from ancestors
    @discardableResult
    public func noTitle() -> HTML._Attributes<Self> {
        self.title(Title.empty)
    }
}
