import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func start(
        _ value: HTML.Start.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Start.Attribute.attribute, value?.description)
    }
}
