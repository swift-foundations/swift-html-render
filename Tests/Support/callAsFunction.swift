//
//  callAsFunction.swift
//  swift-html-rendering
//
//  Test helpers enabling `tag("div") { content }` chaining.
//

extension HTML.Tag {
    @inlinable
    public func callAsFunction() -> HTML.Element.Tag<HTML.Empty> {
        HTML.Element.Tag(tag: self.rawValue) { HTML.Empty() }
    }

    @inlinable
    public func callAsFunction<T: HTML.View>(@HTML.Builder _ content: () -> T) -> HTML.Element.Tag<T> {
        HTML.Element.Tag(tag: self.rawValue, content: content)
    }
}

extension HTML.Element.Tag where Content == HTML.Empty {
    @inlinable
    public func callAsFunction<T: HTML.View>(@HTML.Builder _ content: () -> T) -> HTML.Element.Tag<T> {
        HTML.Element.Tag<T>(tag: self.tagName, content: content)
    }
}
