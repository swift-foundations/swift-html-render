import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func type(
        _ value: HTML.OrderedList.`Type`.Attribute?
    ) -> HTML._Attributes<Self> {
        typealias Value = HTML.OrderedList.`Type`.Attribute
        return self.attribute(Value.attribute, value?.description)
    }
}
