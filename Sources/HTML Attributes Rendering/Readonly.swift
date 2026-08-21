import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    package var readonly: HTML._Attributes<Self> {
        self.attribute(HTML.Readonly.Attribute.attribute)
    }

    @HTML.Builder
    package func readonly(
        _ value: HTML.Readonly.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
