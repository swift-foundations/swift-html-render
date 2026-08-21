public import Render_Primitives
public import WHATWG_HTML_Shared

#if canImport(SwiftUI)
    @unsafe @preconcurrency import SwiftUI
#endif

extension HTML {

    public struct Document<Body: HTML.View, Head: HTML.View>: HTML.__DocumentProtocol {

        @_implements(Render.View,Body)
        public typealias _RenderingBody = Body

        #if canImport(SwiftUI) && canImport(WebKit) && (os(macOS) || os(iOS))
            @_implements(SwiftUI.View,Body)
            public typealias _SwiftUIBody = Never
        #endif

        public let head: Head
        public let body: Body

        public init(
            @HTML.Builder body: () -> Body,
            @HTML.Builder head: () -> Head = { HTML.Empty() }
        ) {
            self.body = body()
            self.head = head()
        }
    }
}

extension HTML.Document {

    @_disfavoredOverload
    public init(
        @HTML.Builder head: () -> Head = { HTML.Empty() },
        @HTML.Builder body: () -> Body
    ) {
        self.body = body()
        self.head = head()
    }
}

extension HTML.Document: Sendable where Body: Sendable, Head: Sendable {}

extension HTML.Document {
    public typealias `Protocol` = HTML.__DocumentProtocol
}
