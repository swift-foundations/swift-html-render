import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    package var multiple: HTML._Attributes<Self> {
        self.attribute(HTML.Multiple.Attribute.attribute)
    }

    @HTML.Builder
    package func multiple(_ value: HTML.Multiple.Attribute?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
