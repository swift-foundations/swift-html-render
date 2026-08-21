import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func muted(
        _ value: HTML.Muted.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
