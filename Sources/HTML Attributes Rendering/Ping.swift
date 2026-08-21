import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func ping(
        _ value: HTML.Ping.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Ping.Attribute.attribute, value?.description)
    }
}
