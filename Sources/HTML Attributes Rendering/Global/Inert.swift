import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    public var inert: HTML._Attributes<Self> {
        self.attribute(HTML.Inert.Attribute.attribute)
    }

    @HTML.Builder
    package func inert(_ value: HTML.Inert.Attribute?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
