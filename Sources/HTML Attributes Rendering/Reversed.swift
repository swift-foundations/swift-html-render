import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func reversed(
        _ value: HTML.Reversed.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
