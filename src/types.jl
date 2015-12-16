type Elem <: XML
    name::AbstractString
    attrs::Dict{AbstractString, AbstractString}
    elems::Vector
    Elem() = new("", Dict(), [])
end

type Document <: XML
    doctype::Nullable{AbstractString}
    elems::Vector
    Document() = new(Nullable(), [])
end

function Document(l)
    doc = Document()
    stack = XML[doc]
    for e in l
        if isa(e, AbstractString)
            push!(stack[end].elems, e)
        elseif isa(e, Tag)
            t = Elem()
            t.name = e.name
            if e.t == 2
                #end tag
                t = pop!(stack)
                # maybe malformed documents (end tag that hasn't started)
                # should fail more grazefully than no field error
                while t.name != e.name
                    t = pop!(stack)
                end
                continue
            elseif e.t == 1
                #start tag
                push!(stack[end].elems, t)
                push!(stack, t)
            elseif e.t == 3
                # nothing
                push!(stack[end].elems, t)
            else
                unreachable
            end
            for i in e.attrs
                if length(i.value) ≥ 2 && first(i.value) == last(i.value) == '"'
                    t.attrs[i.name] = i.value[2:end-1]
                else
                    t.attrs[i.name] = i.value
                end
            end
        else
            unreachable
        end
        
    end
    doc
end

function Base.show(io::IO, d::Document)
    if !isnull(d.doctype)
        println(io, "<?", get(d.doctype), "?>")
    end
    for e in d.elems
        print(io, e)
    end
end

function Base.show(io::IO, d::Elem)
    print(io, "<", d.name)
    for (k,v) in d.attrs
        print(io, " ", k, "=\"", v, "\"")
    end
    print(io, ">")

    for e in d.elems
        print(io, e)
    end
    print(io, "</", d.name, ">")
end
