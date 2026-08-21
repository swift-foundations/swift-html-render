import HTML_Rendering_Core
import HTML_Standard_Attributes
private import WHATWG_HTML_ScriptAttributes

extension HTML.View {

    @discardableResult
    package func async(
        _ value: WHATWG.HTML.Async.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
