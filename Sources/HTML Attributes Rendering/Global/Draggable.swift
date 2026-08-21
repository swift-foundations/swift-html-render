import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func draggable(
        _ value: HTML.Draggable.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Draggable.Attribute.attribute, value.description)
    }

    public var draggable: HTML._Attributes<Self> {
        self.draggable(.true)
    }
}
