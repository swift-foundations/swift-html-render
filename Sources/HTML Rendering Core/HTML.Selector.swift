import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {

    public struct Selector: RawRepresentable, Hashable, Sendable, ExpressibleByStringLiteral,
        ExpressibleByStringInterpolation
    {

        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            self.init(rawValue: value)
        }
    }
}

extension HTML.Selector {

    public func descendant(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " " + self.rawValue)
    }

    public func child(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " > " + self.rawValue)
    }

    public func nextSibling(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " + " + self.rawValue)
    }

    public func adjacent(to other: HTML.Selector) -> HTML.Selector {
        nextSibling(of: other)
    }

    public func subsequentSibling(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " ~ " + self.rawValue)
    }

    public func sibling(of other: HTML.Selector) -> HTML.Selector {
        subsequentSibling(of: other)
    }

    public func column(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " || " + self.rawValue)
    }
}

extension HTML.Selector {

    public func or(_ other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: self.rawValue + ", " + other.rawValue)
    }

    public func or(_ others: HTML.Selector...) -> HTML.Selector {
        let allSelectors = [self] + others
        return .init(rawValue: allSelectors.map(\.rawValue).joined(separator: ", "))
    }

    public func and(_ other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: self.rawValue + other.rawValue)
    }
}

extension HTML.Selector {

    public func withClass(_ className: String) -> HTML.Selector {
        self.and(.class(className))
    }

    public func withId(_ idName: String) -> HTML.Selector {
        self.and(.id(idName))
    }

    public func withAttribute(_ name: String, equals value: String) -> HTML.Selector {
        self.and(.attribute(name, equals: value))
    }

    public func withPseudo(_ pseudo: HTML.Pseudo) -> HTML.Selector {
        .init(rawValue: self.rawValue + pseudo.rawValue)
    }
}

extension HTML.Selector {

    public static let universal: Self = "*"

    public func namespace(_ ns: String) -> HTML.Selector {
        .init(rawValue: "\(ns)|\(self.rawValue)")
    }

    public static func namespace(_ ns: String, element: HTML.Selector) -> HTML.Selector {
        element.namespace(ns)
    }
}

extension HTML.Selector {

    public static func hasAttribute(_ name: String) -> Self {
        "[\(name)]"
    }

    public static func attribute(_ name: String, equals value: String) -> Self {
        "[\(name)=\"\(value)\"]"
    }

    public static func attribute(_ name: String, containsWord value: String) -> Self {
        "[\(name)~=\"\(value)\"]"
    }

    public static func attribute(_ name: String, startsWith value: String) -> Self {
        "[\(name)^=\"\(value)\"]"
    }

    public static func attribute(_ name: String, endsWith value: String) -> Self {
        "[\(name)$=\"\(value)\"]"
    }

    public static func attribute(_ name: String, contains value: String) -> Self {
        "[\(name)*=\"\(value)\"]"
    }

    public static func attribute(_ name: String, startsWithOrHyphen value: String) -> Self {
        "[\(name)|=\"\(value)\"]"
    }
}

extension HTML.Selector {

    public static func `class`(_ name: String) -> Self {
        ".\(name)"
    }

    public static func id(_ name: String) -> Self {
        "#\(name)"
    }
}

extension HTML.Selector {

    public static func inputType(_ type: String) -> Self {
        "input[type=\"\(type)\"]"
    }

    public static let inputText: Self = "input[type=\"text\"]"
    public static let inputPassword: Self = "input[type=\"password\"]"
    public static let inputEmail: Self = "input[type=\"email\"]"
    public static let inputNumber: Self = "input[type=\"number\"]"
    public static let inputTel: Self = "input[type=\"tel\"]"
    public static let inputUrl: Self = "input[type=\"url\"]"
    public static let inputSearch: Self = "input[type=\"search\"]"
    public static let inputDate: Self = "input[type=\"date\"]"
    public static let inputTime: Self = "input[type=\"time\"]"
    public static let inputDatetime: Self = "input[type=\"datetime-local\"]"
    public static let inputMonth: Self = "input[type=\"month\"]"
    public static let inputWeek: Self = "input[type=\"week\"]"
    public static let inputColor: Self = "input[type=\"color\"]"
    public static let inputRange: Self = "input[type=\"range\"]"
    public static let inputFile: Self = "input[type=\"file\"]"
    public static let inputCheckbox: Self = "input[type=\"checkbox\"]"
    public static let inputRadio: Self = "input[type=\"radio\"]"
    public static let inputSubmit: Self = "input[type=\"submit\"]"
    public static let inputReset: Self = "input[type=\"reset\"]"
    public static let inputButton: Self = "input[type=\"button\"]"
    public static let inputHidden: Self = "input[type=\"hidden\"]"
}
