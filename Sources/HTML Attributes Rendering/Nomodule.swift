import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func nomodule(
        _ value: HTML.Nomodule.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
