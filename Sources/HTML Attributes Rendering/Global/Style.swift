import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func style(
        _ css: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Style.Attribute.attribute, css)
    }

    @discardableResult
    public func style(
        _ declarations: [String: String]
    ) -> HTML._Attributes<Self> {
        let formattedDeclarations = declarations.map { key, value in
            "\(key): \(value)"
        }.joined(separator: "; ")

        return self.attribute(HTML.Style.Attribute.attribute, formattedDeclarations)
    }

    @discardableResult
    public func style(
        _ attribute: WHATWG.HTML.Style.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Style.Attribute.attribute, attribute.description)
    }
}
