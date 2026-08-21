import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    package var required: HTML._Attributes<Self> {
        self.attribute(HTML.Required.Attribute.attribute)
    }

    @HTML.Builder
    package func required(
        _ value: HTML.Required.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
