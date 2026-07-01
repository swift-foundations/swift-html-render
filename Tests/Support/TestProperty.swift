//
//  TestProperty.swift
//  swift-html-rendering
//
//  String-based CSS property for testing.
//

public struct TestProperty: W3C_CSS_Shared.Property, GlobalConvertible {
    public static var property: String { "" }
    public let name: String
    public let value: String

    public init(_ name: String, _ value: String) {
        self.name = name
        self.value = value
    }

    public static func global(_ global: Global) -> TestProperty {
        TestProperty("", global.rawValue)
    }

    public var description: String {
        value
    }

    public var declaration: Declaration {
        Declaration(description: "\(name):\(value)")
    }
}

extension HTML.View {
    public func inlineStyle(
        _ property: String,
        _ value: String,
        atRule: HTML.AtRule? = nil,
        selector: HTML.Selector? = nil,
        pseudo: HTML.Pseudo? = nil
    ) -> HTML.Styled<Self, TestProperty> {
        HTML.Styled(
            self,
            TestProperty(property, value),
            atRule: atRule,
            selector: selector,
            pseudo: pseudo
        )
    }
}
