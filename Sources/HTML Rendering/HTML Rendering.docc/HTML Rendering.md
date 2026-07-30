# ``HTML_Rendering``

@Metadata {
    @DisplayName("HTML Rendering")
    @TitleHeading("Swift Foundations")
}

The umbrella product combining `HTML Elements Rendering` (one render
function per HTML element — `div`, `form`, `ol`, and the rest) and `HTML
Attributes Rendering`, both built on `HTML Rendering Core`'s `HTML.View`
protocol and `HTML.Context`, which renders a view tree to a UTF-8 byte
buffer (with an async, chunked streaming path for progressive output).

## When to use this

Reach for this package when code needs to render `swift-html-standard`
element and attribute types to actual HTML markup — it is the rendering
layer the sibling `swift-html` convenience package builds on. Depend on
`HTML Rendering Core` alone when only the `HTML.View`/`HTML.Context`
rendering engine is needed without the per-element render functions; depend
on `swift-html-standard` alone when only the typed element vocabulary is
needed without rendering.

## Topics

### Related packages

- [swift-html-standard](https://github.com/swift-standards/swift-html-standard) —
  the typed HTML element and attribute vocabulary this package renders.
- [swift-html](https://github.com/swift-foundations/swift-html) — the
  lowercase element-syntax layer built on this renderer.
