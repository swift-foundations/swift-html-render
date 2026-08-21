public import Render_Primitives
public import WHATWG_HTML_Shared

extension Render._Tuple: HTML.View where repeat each Content: HTML.View {}
