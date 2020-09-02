module PairAsPipe

export @pap

using MacroTools
using MacroTools: @capture

macro pap(ex)
    has_newcol = @capture(ex, newcol_ = rhs_)

    if !has_newcol
        rhs = ex
    end

    # for obtaining symbols
    symbols = QuoteNode[]
    gen_symbols = Symbol[]
    rhs = MacroTools.postwalk(function(x)
        if x isa QuoteNode
            push!(symbols, x)
            push!(gen_symbols, MacroTools.gensym(x.value))
            return gen_symbols[end]
        else
            return x
        end
    end, rhs)

    lhs = Expr(:tuple, gen_symbols...)

    # the fn in
    # :col => fn
    fn = Expr(:->, lhs, rhs)

    # the [:col1, :col2] in
    # the [:col1, :col2] => fn
    cols = Expr(:vect, symbols...)

    if has_newcol
        fn = Expr(:call, :(=>), fn, QuoteNode(newcol))
    end

    Expr(:call, :(=>), cols, fn)
end

end
