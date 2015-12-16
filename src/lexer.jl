type Attr
    name::AbstractString
    value::AbstractString
end
Attr(name) = Attr(name, "")

type Tag
    t::Int
    name::AbstractString
    attrs::Vector{Attr}
end
Tag(t, rest) = Tag(t, rest[1], rest[2:end])

spc = Drop(Star(Space()))


doctype = E"<?" + p"[^?]*" + E"?>" |> x->Tag(0, x)
attrnq = p"[^ =<>/?]+" + E"=" + p"[^ =<>/?\"]+"
attrq = p"[^ =<>/?]+" + E"=" + p"\"[^\"]*\""
attre =  p"[^ =<>/?]+" + E" "
attr = attrnq | attrq | attre > Attr
tag = E"<" + p"[^?>/ ]*" + spc + Star(attr + spc) + E">" + spc |> x->Tag(1, x)
endtag = E"</" + spc + p"[^?>/ ]*" + spc + E">" + spc |> x->Tag(2, x)
stag = E"<" + p"[^?>/ ]*" + spc + Star(attr + spc) + E"/" + spc + E">" + spc |> x->Tag(3, x)
text = p"[^<]+"
comment = E"<!--" + Drop(p".+?-->") + spc
elem = comment | text | tag | stag | endtag
all = doctype[0:1] + spc + elem[1:end] + Eos()

