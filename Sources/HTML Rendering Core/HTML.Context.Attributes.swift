public import Buffer_Linear_Primitive
public import Column_Primitives
public import Dictionary_Ordered_Primitives
public import Dictionary_Primitives
public import Hash_Indexed_Primitive
import Hash_Primitives
public import Ownership_Shared_Primitive
public import WHATWG_HTML_Shared

extension HTML.Context {

    public typealias Attributes = __DictionaryOrdered<
        Ownership.Shared<
            Hash.Entry<String, String>,
            Hash.Indexed<Column.Heap<Hash.Entry<String, String>>>
        >
    >

    public typealias Styles = __DictionaryOrdered<
        Ownership.Shared<
            Hash.Entry<HTML.Style.Rule, String>,
            Hash.Indexed<Column.Heap<Hash.Entry<HTML.Style.Rule, String>>>
        >
    >
}
