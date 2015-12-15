module QDXML

using ParserCombinator

abstract XML

include("types.jl")
include("lexer.jl")

parse_string(s) = parse_one(s, all) |> Document
parse_file(f) = readall(f) |> parse_string

end # module
