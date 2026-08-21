import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func accept(
        _ value: HTML.Accept.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Accept.Attribute.attribute, value?.description)
    }

    @discardableResult
    package func accept(
        _ fileTypes: HTML.Accept.Attribute.FileType?...
    ) -> HTML._Attributes<Self> {
        self.accept(HTML.Accept.Attribute(fileTypes.compactMap { $0 }))
    }

    @discardableResult
    package func accept(
        _ fileTypes: [HTML.Accept.Attribute.FileType?]
    ) -> HTML._Attributes<Self> {
        self.accept(HTML.Accept.Attribute(fileTypes.compactMap { $0 }))
    }
}
