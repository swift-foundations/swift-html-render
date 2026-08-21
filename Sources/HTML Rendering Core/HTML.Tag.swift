import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    public static var tag: HTML.Tag.Type {
        HTML.Tag.self
    }
}

extension HTML {

    public struct Tag {

        public let rawValue: String

        internal init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension HTML.Tag {

    @inlinable
    public static var doctype: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.exclamationPoint,
            .ascii.d, .ascii.o, .ascii.c, .ascii.t, .ascii.y, .ascii.p, .ascii.e,
            .ascii.space,
            .ascii.h, .ascii.t, .ascii.m, .ascii.l,
            .ascii.greaterThanSign,
        ]
    }

    @inlinable
    public static var open: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.h, .ascii.t, .ascii.m, .ascii.l,
            .ascii.greaterThanSign,
        ]
    }

    @inlinable
    public static var close: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.h, .ascii.t, .ascii.m, .ascii.l,
            .ascii.greaterThanSign,
        ]
    }

    @inlinable
    public static var headOpen: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.h, .ascii.e, .ascii.a, .ascii.d,
            .ascii.greaterThanSign,
        ]
    }

    @inlinable
    public static var headClose: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.h, .ascii.e, .ascii.a, .ascii.d,
            .ascii.greaterThanSign,
        ]
    }

    @inlinable
    public static var bodyOpen: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.b, .ascii.o, .ascii.d, .ascii.y,
            .ascii.greaterThanSign,
        ]
    }

    @inlinable
    public static var bodyClose: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.b, .ascii.o, .ascii.d, .ascii.y,
            .ascii.greaterThanSign,
        ]
    }

    @inlinable
    public static var styleOpen: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.s, .ascii.t, .ascii.y, .ascii.l, .ascii.e,
            .ascii.greaterThanSign,
        ]
    }

    @inlinable
    public static var styleClose: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.s, .ascii.t, .ascii.y, .ascii.l, .ascii.e,
            .ascii.greaterThanSign,
        ]
    }
}
