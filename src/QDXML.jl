__precompile__()
module QDXML

using ParserCombinator

export XML

abstract XML

include("types.jl")
include("lexer.jl")
include("utils.jl")

parse_string(s) = parse_one(s, all) |> Document
parse_file(f) = readall(f) |> parse_string

"""
Parse the given filename, open file or string as XML. If the document doesn't start with doctype or a tag, please use `parse_string(s)`
"""
XML(s) = isa(s, AbstractString) && first(s) == '<' ? parse_string(s) : parse_file(s)

end # module
