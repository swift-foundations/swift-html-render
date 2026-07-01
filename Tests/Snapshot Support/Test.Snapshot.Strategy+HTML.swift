//
//  Test.Snapshot.Strategy+HTML.swift
//  swift-html-rendering
//

public import HTML_Rendering_Core
public import Test_Snapshot_Primitives
public import WHATWG_HTML_Shared

extension Test.Snapshot.Strategy where Value: HTML.Document.`Protocol`, Format == String {
    public static var html: Self {
        .html()
    }

    public static func html(
        configuration: HTML.Context.Configuration = .pretty
    ) -> Self {
        Test.Snapshot.Strategy<String, String>.lines.pullback { value in
            HTML.Context.Configuration.$current.withValue(configuration) {
                (try? String(value)) ?? "HTML rendering failed"
            }
        }
    }
}

extension Test.Snapshot.Strategy where Value: HTML.View, Format == String {
    public static var html: Self {
        .html()
    }

    public static func html(
        configuration: HTML.Context.Configuration = .pretty
    ) -> Self {
        Test.Snapshot.Strategy<String, String>.lines.pullback { value in
            HTML.Context.Configuration.$current.withValue(configuration) {
                (try? String(value)) ?? "HTML rendering failed"
            }
        }
    }
}
