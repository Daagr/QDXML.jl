#TODO:
# docs
# readme
# tests

module QDXML

using ParserCombinator

export XML

abstract XML

include("types.jl")
include("lexer.jl")
include("utils.jl")

parse_string(s) = parse_one(s, all) |> Document
parse_file(f) = readall(f) |> parse_string

XML(s) = isa(s, AbstractString) && first(s) == '<' ? parse_string(s) : parse_file(s)

end # module
