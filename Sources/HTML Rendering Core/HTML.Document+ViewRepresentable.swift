#if canImport(SwiftUI) && canImport(WebKit)
    #if os(macOS)
        import AppKit
    #endif
    @preconcurrency public import SwiftUI
    public import WebKit
    public import WHATWG_HTML_Shared

    extension HTML.Document {
        @MainActor
        fileprivate func makeWebView() -> WKWebView {
            let configuration = WKWebViewConfiguration()
            configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")

            let webView = WKWebView(frame: .zero, configuration: configuration)
            loadHTML(into: webView)
            return webView
        }

        @MainActor
        fileprivate func loadHTML(into webView: WKWebView) {
            let html: String
            do throws(HTML.Context.Configuration.Error) {
                html = try String(self)
            } catch {
                html = """
                    <!doctype html>
                    <html>
                    <body style="font-family: system-ui; color: #c00; padding: 20px;">
                    <p>Failed to render HTML document</p>
                    </body>
                    </html>
                    """
            }
            webView.loadHTMLString(html, baseURL: nil)
        }
    }

    #if os(macOS)
        extension HTML.Document: SwiftUI.View {}

        extension HTML.Document: SwiftUI.NSViewRepresentable {
            public typealias NSViewType = WKWebView

            public func makeNSView(context: NSViewRepresentableContext<Self>) -> WKWebView {
                makeWebView()
            }

            public func updateNSView(
                _ webView: WKWebView,
                context: NSViewRepresentableContext<Self>
            ) {
                loadHTML(into: webView)
            }
        }

    #elseif os(iOS)
        extension HTML.Document: SwiftUI.View {}

        extension HTML.Document: SwiftUI.UIViewRepresentable {
            public typealias UIViewType = WKWebView

            public func makeUIView(context: UIViewRepresentableContext<Self>) -> WKWebView {
                makeWebView()
            }

            public func updateUIView(
                _ webView: WKWebView,
                context: UIViewRepresentableContext<Self>
            ) {
                loadHTML(into: webView)
            }
        }
    #endif
#endif
