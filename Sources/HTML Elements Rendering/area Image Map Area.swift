//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import WHATWG_HTML_Embedded

extension WHATWG.HTML.Area.Element: HTML.View {
    public var body: some HTML.View {
        HTML.Tag.Element(for: Self.self) { HTML.Empty() }
            //        NEED TO FIX AREA domain model
            //            .shape(self.shape)
            //            .coords(self.coords)
            .alt(self.alt)
            .href(self.href)
            .download(download)
            .ping(ping)
            .referrerPolicy(referrerpolicy)
            .rel(rel)
            .target(target)
    }
}
