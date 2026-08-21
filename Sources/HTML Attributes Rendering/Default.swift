import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func `default`(
        _ value: HTML.Default.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
