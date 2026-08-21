import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    package var novalidate: HTML._Attributes<Self> {
        self.attribute(HTML.Novalidate.Attribute.attribute)
    }

    @HTML.Builder
    package func novalidate(
        _ value: HTML.Novalidate.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
