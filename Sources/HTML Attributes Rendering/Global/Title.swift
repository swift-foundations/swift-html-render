import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func title(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Title.Attribute.attribute, value)
    }

    @discardableResult
    public func title(
        lines: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Title.Attribute.attribute, lines.joined(separator: "\n"))
    }

    @discardableResult
    public func title(
        lines: String...
    ) -> HTML._Attributes<Self> {
        self.title(lines: lines)
    }

    @discardableResult
    public func title(
        _ attribute: HTML.Title.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Title.Attribute.attribute, attribute?.description)
    }

    @discardableResult
    public func noTitle() -> HTML._Attributes<Self> {
        self.title(HTML.Title.Attribute.empty)
    }
}
