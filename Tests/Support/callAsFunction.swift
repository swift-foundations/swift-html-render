extension HTML.Tag {
    @inlinable
    public func callAsFunction() -> HTML.Tag.Element<HTML.Empty> {
        HTML.Tag.Element(tag: self.rawValue) { HTML.Empty() }
    }

    @inlinable
    public func callAsFunction<T: HTML.View>(
        @HTML.Builder _ content: () -> T
    ) -> HTML.Tag.Element<T> {
        HTML.Tag.Element(tag: self.rawValue, content: content)
    }
}

extension HTML.Tag.Element where Content == HTML.Empty {
    @inlinable
    public func callAsFunction<T: HTML.View>(
        @HTML.Builder _ content: () -> T
    ) -> HTML.Tag.Element<T> {
        HTML.Tag.Element<T>(tag: self.tagName, content: content)
    }
}
