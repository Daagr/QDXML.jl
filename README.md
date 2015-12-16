# QDXML

Quick and Dirty XML parser. And by quick I mean quickly written; doesn't support many XML features like character references &epsilon;&cent;.

## Usage

```julia
using QDXML
x = XML(xml_file) # or
x = XML("<a>b</a>")

x["a"] # first element named "a"
x["a", :] # Array of all elements "a"

for elem in x # iterate through all elements
    elem.elems # Array of all child-elements and text
    elem.attrs # Dict of all attributes
    elem.name
end
```

If `XML` thinks document is a file name, you can use `QDXML.parse_string(s)`.
