//
//  tag.swift
//  swift-html-rendering
//
//  SPI-exposed function for creating HTML elements from string tag names.
//

public import WHATWG_HTML_Shared

// MARK: - Tag Function (SPI)

/// Creates an HTML element with the specified tag name and content.
///
/// This function allows creating HTML elements dynamically from string tag names.
/// It's exposed via SPI because in most cases you should prefer the typed element
/// functions like `div()`, `span()`, etc. for better type safety.
///
/// - Parameters:
///   - tagName: The name of the HTML tag.
///   - content: A closure that returns the content for this element.
/// - Returns: An HTML element with the specified tag and content.
///
/// - Note: Import with `@_spi(DynamicHTML) import HTML_Rendering_Core` to access this function.
@_spi(DynamicHTML)
@inlinable
public func tag<T: HTML.View>(
    _ tagName: String,
    @HTML.Builder _ content: () -> T = { HTML.Empty() }
) -> HTML.Element.Tag<T> {
    HTML.Element.Tag(tag: tagName, content: content)
}

/// Creates an empty HTML element with the specified tag name.
///
/// - Parameter tagName: The name of the HTML tag.
/// - Returns: An HTML element with the specified tag and no content.
@_spi(DynamicHTML)
@inlinable
public func tag(_ tagName: String) -> HTML.Element.Tag<HTML.Empty> {
    HTML.Element.Tag(tag: tagName) { HTML.Empty() }
}
