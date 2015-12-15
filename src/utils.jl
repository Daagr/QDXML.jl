
function Base.getindex(d::XML, name::AbstractString)
    name = lowercase(name)
    for elem in d
        if !isa(elem, Text) && lowercase(elem.name) == name
            return elem
        end
    end
end
function Base.getindex(d::XML, name::AbstractString, ::Colon)
    name = lowercase(name)
    found = []
    for elem in d
        if !isa(elem, Text) && lowercase(elem.name) == name
            push!(found, elem)
        end
    end
    return found
end


Base.start(t::Text) = false
Base.done(::Text, v) = v
Base.next(t::Text, ::Any) = t.data, true

Base.start(d::XML) = reverse(d.elems)

Base.done(::XML, s) = isempty(s)

function Base.next(d::XML, s)
    v = pop!(s)
    if !isa(v, Text)
        append!(s, reverse(v.elems))
    end
    return v, s
end
