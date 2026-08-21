import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    package var checked: HTML._Attributes<Self> {
        self.attribute(HTML.Checked.Attribute.attribute)
    }

    @HTML.Builder
    package func checked(_ value: HTML.Checked.Attribute?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
