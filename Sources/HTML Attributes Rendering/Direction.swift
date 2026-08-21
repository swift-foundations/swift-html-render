import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func direction(
        _ value: WHATWG.HTML.Direction.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG.HTML.Direction.Attribute.attribute, value?.description)
    }
}
