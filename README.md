# swift-html-render

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Renders declarative `HTML.View` trees to escaped HTML markup as a `String` or UTF-8 bytes.

---

## Key Features

- **Declarative view tree** — Build markup from `HTML.View` components with a `@HTML.Builder` `body`, composed like SwiftUI.
- **Automatic escaping** — Text content is escaped on render (`&`, `<`, `>`; attribute values additionally escape `"` and `'`), so interpolated data cannot break out of its context.
- **Typed throws** — `String` and byte conversions throw a single typed `HTML.Context.Configuration.Error`.
- **String or bytes output** — Render the same view to `String`, `[UInt8]`, or `ContiguousArray<UInt8>`.
- **Asynchronous rendering** — `await String(view)` and `await [UInt8](view)` for non-blocking serialization.
- **Complete documents** — `HTML.Document` emits a full page with doctype, `<html>`, `<head>`, and `<body>`.
- **Format-agnostic core** — `HTML.View` refines `Render.View`, so one view tree can target any `Render.Context` output.

---

## Quick Start

A view's text is escaped when it is rendered, so user-supplied content is safe to embed directly — naive string interpolation would inject the `<b>` markup verbatim:

```swift
import HTML_Rendering

// A reusable component in the view tree.
struct Comment: HTML.View {
    let author: String
    let message: String

    var body: some HTML.View {
        HTML.Group {
            HTML.Text(author)
            HTML.Text(": ")
            HTML.Text(message)
        }
    }
}

let comment = Comment(author: "Ada", message: "<b>hi</b>")
let markup = try String(comment)
// markup == "Ada: &lt;b&gt;hi&lt;/b&gt;"
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-html-render.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "HTML Rendering", package: "swift-html-render")
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26.

---

## Architecture

Five library products. The umbrella `HTML Rendering` is the default import; the other targets let consumers narrow the surface.

| Product | Import | When to import |
|---------|--------|----------------|
| `HTML Rendering` | `HTML_Rendering` | Default. Element builders, attribute helpers, and the rendering engine in one import. |
| `HTML Elements Rendering` | `HTML_Elements_Rendering` | Typed element builders with attribute helpers (transitively includes Attributes and Core). |
| `HTML Attributes Rendering` | `HTML_Attributes_Rendering` | Attribute application and the engine, without the standard element builders. |
| `HTML Rendering Core` | `HTML_Rendering_Core` | The engine alone — `HTML.View`, `HTML.Text`, `HTML.Document`, escaping, and `String` / byte serialization — without standard elements or attributes. |
| `HTML Rendering Core Test Support` | `HTML_Rendering_Core_Test_Support` | Test-target helpers (a public `tag(_:)` builder, element constructors, and a `TestProperty`) for asserting rendered output. |

---

## Community

<!-- BEGIN: discussion -->
*Discussion thread will be created at first public release.*
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE](LICENSE.md).
