import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Base.Element {
    @HTML.Builder
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        let element = HTML.Tag.Element(for: Self.self) { content() }
        switch self.configuration {
        case .href(let href):
            element.href(href)

        case .target(let target):
            element.target(target)

        case .both(let href, let target):
            element
                .href(href)
                .target(target)
        }
    }
}
