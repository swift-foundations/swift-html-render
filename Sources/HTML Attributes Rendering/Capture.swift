import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func capture(
        _ value: HTML.Capture.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Capture.Attribute.attribute, value?.description)
    }
}
