import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    public var itemscope: HTML._Attributes<Self> {
        self.attribute(HTML.Itemscope.Attribute.attribute)
    }

    @discardableResult
    public func itemscope(
        _ value: HTML.Itemscope.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
