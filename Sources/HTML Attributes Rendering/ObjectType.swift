import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func type(
        _ value: HTML.ExternalObject.`Type`.Attribute?
    ) -> HTML._Attributes<Self> {
        typealias Value = HTML.ExternalObject.`Type`.Attribute
        return self.attribute(Value.attribute, value?.description)
    }
}
