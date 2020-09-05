## PairAsPipe.jl

**P**air**A**s**P**ipe (`@pap`) is friendly with DataFrames.jl's API.

The macro `@pap` is designed to transform `newcol = fn(:col)` to `:col => fn => :newcol` which is an elegant (ab)use of pairs syntax (`a => b`) as pipes. Hence the name of the package.

### Usage

Some examples
```julia
using DataFrames, PairAsPipe

df = DataFrame(a = 1:3)

transform(df, @pap b = :a .* 2) # same as transform(df, :a => a->a.*2 => :b)

transform(df, @pap :a .* 2) # same as transform(df, :a => a->a.*2); except for output column name

transform(df, @pap sum(:a)) # same as transform(df, :a => mean); except for output column name

filter(@pap(:a == 1), df) # same as filter([:a] => a -> a == 1, df)
```

### Similar Work

* [DataFramesMacros.jl](https://github.com/matthieugomez/DataFramesMacros.jl)
* [DataFramesMeta.jl](https://github.com/JuliaData/DataFramesMeta.jl)
