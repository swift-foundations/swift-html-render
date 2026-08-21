import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func face(
        _ value: HTML.Face.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Face.Attribute.attribute, value?.description)
    }
}
