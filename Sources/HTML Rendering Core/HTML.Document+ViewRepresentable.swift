#if canImport(SwiftUI)
#if os(macOS)
import AppKit
#endif
@preconcurrency public import SwiftUI
public import WebKit
public import WHATWG_HTML_Shared

// MARK: - Shared Implementation

private extension HTML.Document {
    @MainActor
    func makeWebView() -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")

        let webView = WKWebView(frame: .zero, configuration: configuration)
        loadHTML(into: webView)
        return webView
    }

    @MainActor
    func loadHTML(into webView: WKWebView) {
        let html = (try? String(self)) ?? """
            <!doctype html>
            <html>
            <body style="font-family: system-ui; color: #c00; padding: 20px;">
            <p>Failed to render HTML document</p>
            </body>
            </html>
            """
        webView.loadHTMLString(html, baseURL: nil)
    }
}

// MARK: - macOS

#if os(macOS)
extension HTML.Document: SwiftUI.View {}

extension HTML.Document: SwiftUI.NSViewRepresentable {
    public typealias NSViewType = WKWebView

    public func makeNSView(context: NSViewRepresentableContext<Self>) -> WKWebView {
        makeWebView()
    }

    public func updateNSView(_ webView: WKWebView, context: NSViewRepresentableContext<Self>) {
        loadHTML(into: webView)
    }
}

// MARK: - iOS

#elseif os(iOS)
extension HTML.Document: SwiftUI.View {}

extension HTML.Document: SwiftUI.UIViewRepresentable {
    public typealias UIViewType = WKWebView

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> WKWebView {
        makeWebView()
    }

    public func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<Self>) {
        loadHTML(into: webView)
    }
}
#endif
#endif
