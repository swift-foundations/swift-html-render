import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func data(
        _ name: some CustomStringConvertible,
        _ value: some CustomStringConvertible
    ) -> HTML._Attributes<Self> {
        let attribute = HTML.Data.Attribute(name: name, value: value)
        return self.attribute(attribute.attributeName, attribute.description)
    }

    @discardableResult
    public func data(
        _ value: HTML.Data.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(value?.attributeName ?? "", value?.description)
    }
}
