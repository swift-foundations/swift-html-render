import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func abbr(
        _ value: HTML.Abbr.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Abbr.Attribute.attribute, value?.description)
    }
}
