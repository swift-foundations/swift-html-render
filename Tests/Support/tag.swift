//
//  tag.swift
//  swift-html-rendering
//
//  Public bridge for the @_spi(DynamicHTML) tag() function.
//  This is the single canonical access point for test code.
//

/// Creates an HTML element with the specified tag name and content.
@_disfavoredOverload
@inlinable
public func tag<T: HTML.View>(
    _ tagName: String,
    @HTML.Builder _ content: () -> T = { HTML.Empty() }
) -> HTML.Element.Tag<T> {
    HTML.Element.Tag(tag: tagName, content: content)
}
