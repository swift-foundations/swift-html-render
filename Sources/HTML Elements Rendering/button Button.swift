//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Element.Button {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .type(self.type)
            .disabled(self.disabled)
            .form(self.form)
            .name(self.name)
            .value(self.value)
            .autofocus(self.autofocus)
            .formAction(self.formaction)
            .formEncType(self.formenctype)
            .formMethod(self.formmethod)
            .formNovalidate(self.formnovalidate)
            .formTarget(self.formtarget)
            .popovertarget(self.popovertarget)
            .popovertargetaction(self.popovertargetaction)
    }
}
