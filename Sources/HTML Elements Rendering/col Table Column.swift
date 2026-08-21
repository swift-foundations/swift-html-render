import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.TableColumn.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .span(self.span)
            .width(self.width)
    }
}
