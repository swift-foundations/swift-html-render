import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func type(
        _ value: HTML.Script.`Type`.Attribute?
    ) -> HTML._Attributes<Self> {
        typealias Value = HTML.Script.`Type`.Attribute
        return self.attribute(Value.attribute, value?.description)
    }
}
