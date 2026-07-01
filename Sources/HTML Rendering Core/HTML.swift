//
//  HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

public import WHATWG_HTML_Shared

extension HTML {
    /// &quot; - Double quotation mark HTML entity
    public static let doubleQuotationMark: [UInt8] = [
        .ascii.ampersand,
        .ascii.q,
        .ascii.u,
        .ascii.o,
        .ascii.t,
        .ascii.semicolon,
    ]

    /// &#39; - Apostrophe HTML entity
    public static let apostrophe: [UInt8] = [
        .ascii.ampersand,
        .ascii.numberSign,
        .ascii.3,
        .ascii.9,
        .ascii.semicolon,
    ]

    /// &amp; - Ampersand HTML entity
    public static let ampersand: [UInt8] = [
        .ascii.ampersand,
        .ascii.a,
        .ascii.m,
        .ascii.p,
        .ascii.semicolon,
    ]

    /// &lt; - Less-than HTML entity
    public static let lessThan: [UInt8] = [
        .ascii.ampersand,
        .ascii.l,
        .ascii.t,
        .ascii.semicolon,
    ]

    /// &gt; - Greater-than HTML entity
    public static let greaterThan: [UInt8] = [
        .ascii.ampersand,
        .ascii.g,
        .ascii.t,
        .ascii.semicolon,
    ]
}
