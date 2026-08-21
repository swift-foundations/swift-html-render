import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func isMap(
        _ value: HTML.Ismap.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
