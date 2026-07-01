///
/// DataAttribute.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func data(
        _ name: some CustomStringConvertible,
        _ value: some CustomStringConvertible
    ) -> HTML._Attributes<Self> {
        let attribute = DataAttribute(name: name, value: value)
        return self.attribute(attribute.attributeName, attribute.description)
    }

    @discardableResult
    public func data(
        _ value: DataAttribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(value?.attributeName ?? "", value?.description)
    }
}
