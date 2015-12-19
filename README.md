# QDXML

[![Build Status](https://travis-ci.org/Daagr/QDXML.jl.svg?branch=master)](https://travis-ci.org/Daagr/QDXML.jl)

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

## Alternatives

I haven't done any benchmarks so QDXML is probably really slow. The alternatives also have better support for some XML features.

#### [LightXML](https://github.com/JuliaLang/LightXML.jl)

- Able to create XML trees
- Not native Julia (wrapper of libxml2) and it shows (`free`)

#### [LibExpat](https://github.com/amitmurthy/LibExpat.jl)

- Really nice XPath queries
- Wrapper for libexpat

#### [PyCall](https://github.com/stevengj/PyCall.jl) + [bs4](http://www.crummy.com/software/BeautifulSoup/)

- Hideously dependant on the environment (Python version, bs4 and xml library)
- Really nice interface that I try to mimic

