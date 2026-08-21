import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func attributionSrc(
        _ value: HTML.AttributionSrc.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.AttributionSrc.Attribute.attribute, value?.description)
    }
}
