using QDXML
using Base.Test

@test XML("<n><k a=b c=d g=\" h i\">g</k><y / ></n>s")["k"].attrs["g"] == " h i"
