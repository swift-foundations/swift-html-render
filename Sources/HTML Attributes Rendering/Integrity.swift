import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func integrity(
        _ value: HTML.Integrity.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Integrity.Attribute.attribute, value?.description)
    }
}
