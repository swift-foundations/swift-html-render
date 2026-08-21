public import WHATWG_HTML_Shared

extension HTML {

    public static let doubleQuotationMark: [UInt8] = [
        .ascii.ampersand,
        .ascii.q,
        .ascii.u,
        .ascii.o,
        .ascii.t,
        .ascii.semicolon,
    ]

    public static let apostrophe: [UInt8] = [
        .ascii.ampersand,
        .ascii.numberSign,
        .ascii.3,
        .ascii.9,
        .ascii.semicolon,
    ]

    public static let ampersand: [UInt8] = [
        .ascii.ampersand,
        .ascii.a,
        .ascii.m,
        .ascii.p,
        .ascii.semicolon,
    ]

    public static let lessThan: [UInt8] = [
        .ascii.ampersand,
        .ascii.l,
        .ascii.t,
        .ascii.semicolon,
    ]

    public static let greaterThan: [UInt8] = [
        .ascii.ampersand,
        .ascii.g,
        .ascii.t,
        .ascii.semicolon,
    ]
}
