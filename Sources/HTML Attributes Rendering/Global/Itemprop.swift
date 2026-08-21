import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func itemprop(
        _ propertyName: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemprop.Attribute.attribute, propertyName)
    }

    @discardableResult
    public func itemprop(
        _ propertyNames: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemprop.Attribute.attribute, propertyNames.joined(separator: " "))
    }

    @discardableResult
    public func itemprop(
        _ propertyNames: String...
    ) -> HTML._Attributes<Self> {
        self.itemprop(propertyNames)
    }

    @discardableResult
    public func itemprop(
        _ attribute: HTML.Itemprop.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Itemprop.Attribute.attribute, attribute.description)
    }
}
