import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func wrap(
        _ value: HTML.Wrap.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Wrap.Attribute.attribute, value?.description)
    }
}
