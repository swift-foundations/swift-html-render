import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.TableDataCell.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .colspan(self.colspan)
            .headers(self.headers)
            .rowspan(self.rowspan)
    }
}
