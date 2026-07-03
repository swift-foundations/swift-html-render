//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Script {
    public func callAsFunction(
        _ script: () -> String = { "" }
    ) -> some HTML.View {

        let script = script()
        var escaped = ""
        escaped.unicodeScalars.reserveCapacity(script.unicodeScalars.count)

        for index in script.unicodeScalars.indices {
            let scalar = script.unicodeScalars[index]
            if scalar == "<",
                script.unicodeScalars[index...].starts(with: "<!--".unicodeScalars)
                    || script.unicodeScalars[index...].starts(with: "<script".unicodeScalars)
                    || script.unicodeScalars[index...].starts(with: "</script".unicodeScalars)
            {
                escaped.unicodeScalars.append(contentsOf: #"\x3C"#.unicodeScalars)
            } else {
                escaped.unicodeScalars.append(scalar)
            }
        }

        return HTML.Element.Tag(for: Self.self) {
            if script.isEmpty { HTML.Empty() } else { HTML.Raw(escaped) }
        }
        .src(self.src)
        .`async`(self.`async`)
        .`defer`(self.`defer`)
        .type(self.type)
        .integrity(self.integrity)
        .referrerPolicy(self.referrerpolicy)
        .nomodule(self.nomodule)
        .fetchPriority(self.fetchpriority)
        .blocking(self.blocking)
        .crossorigin(self.crossorigin)
        .nonce(self.nonce)
        .attributionSrc(self.attributionsrc)
    }
}

extension HTML_Standard_Elements.Script: HTML.View {
    public var body: some HTML.View {
        Script(
            src: self.src,
            async: self.async,
            defer: self.defer,
            type: self.type,
            integrity: self.integrity,
            referrerpolicy: self.referrerpolicy,
            nomodule: self.nomodule,
            fetchpriority: self.fetchpriority,
            blocking: self.blocking,
            crossorigin: self.crossorigin,
            nonce: self.nonce,
            attributionsrc: self.attributionsrc
        ).callAsFunction {
            ""
        }
    }
}
