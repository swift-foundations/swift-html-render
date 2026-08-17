//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

// extension HTMLVoidElement where Self: HTML.Element.HTMLElement & HTML.View {
//    public var body: HTML.Element.Tag<HTML.Empty> {
//        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
//    }
// }

// WORKAROUND because Input and BR fail to compile when called as BR(). With this function BR()() works
// TODO: Re-enable when HTML.VoidElement protocol is available
// extension HTML.VoidElement where Self: HTML.Element.HTML.Element & HTML.View {
//     public func callAsFunction() -> some HTML.View {
//         self
//     }
// }
