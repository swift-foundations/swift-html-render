import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    package var disabled: HTML._Attributes<Self> {
        self.attribute(HTML.Disabled.Attribute.attribute)
    }

    @HTML.Builder
    package func disabled(_ value: HTML.Disabled.Attribute?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
