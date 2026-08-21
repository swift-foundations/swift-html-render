import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func target(
        _ value: HTML.Target.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Target.Attribute.attribute, value?.description)
    }
}

extension HTML.View {

    @discardableResult
    package func target(
        _ value: HTML.FormTarget.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.FormTarget.Attribute.attribute, value?.description)
    }
}

extension HTML.View {

    @discardableResult
    package func target(
        form value: HTML.Target.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Target.Attribute.attribute, value?.description)
    }
}

extension HTML.View {

    @discardableResult
    public func target(
        anchor value: HTML.Target.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Target.Attribute.attribute, value?.description)
    }

    @discardableResult
    @HTML.Builder
    public func openInNewTab(
        withOpener: Bool = false
    ) -> some HTML.View {
        let result = self.target(anchor: .blank)

        if withOpener {
            result
        } else {
            result.rel(.noopener)
        }
    }

    @discardableResult
    public func openInParent() -> HTML._Attributes<Self> {
        self.target(anchor: .parent)
    }

    @discardableResult
    public func openInTop() -> HTML._Attributes<Self> {
        self.target(anchor: .top)
    }
}
