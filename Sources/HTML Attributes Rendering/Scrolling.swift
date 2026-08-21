import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func scrolling(
        _ value: HTML.Scrolling.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Scrolling.Attribute.attribute, value?.rawValue)
    }
}
