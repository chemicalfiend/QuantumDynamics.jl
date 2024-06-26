# Use
#    @warnpcfail precompile(args...)
# if you want to be warned when a precompile directive fails
macro warnpcfail(ex::Expr)
    modl = __module__
    file = __source__.file === nothing ? "?" : String(__source__.file)
    line = __source__.line
    quote
        $(esc(ex)) || @warn """precompile directive
     $($(Expr(:quote, ex)))
 failed. Please report an issue in $($modl) (after checking for duplicates) or remove this directive.""" _file=$file _line=$line
    end
end


function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    Base.precompile(Tuple{typeof(tuple_length),Type{Tuple{1}}})
    Base.precompile(Tuple{typeof(tuple_length),Type{Tuple{2}}})
    Base.precompile(Tuple{typeof(tuple_length),Type{Tuple{3}}})
    Base.precompile(Tuple{typeof(tuple_length),Type{Tuple{4}}})
    Base.precompile(Tuple{typeof(tuple_length),Type{Tuple{5}}})
    Base.precompile(Tuple{typeof(tuple_length),Type{Tuple{6}}})
    Base.precompile(Tuple{typeof(tuple_minimum),Type{Tuple{0}}})
    Base.precompile(Tuple{typeof(tuple_minimum),Type{Tuple{1}}})
    Base.precompile(Tuple{typeof(tuple_minimum),Type{Tuple{2}}})
    Base.precompile(Tuple{typeof(tuple_minimum),Type{Tuple{3}}})
    Base.precompile(Tuple{typeof(tuple_minimum),Type{Tuple{4}}})
    Base.precompile(Tuple{typeof(tuple_minimum),Type{Tuple{5}}})
    Base.precompile(Tuple{typeof(tuple_minimum),Type{Tuple{6}}})
    Base.precompile(Tuple{typeof(tuple_prod),Type{Tuple{0}}})
    Base.precompile(Tuple{typeof(tuple_prod),Type{Tuple{1}}})
    Base.precompile(Tuple{typeof(tuple_prod),Type{Tuple{2}}})
    Base.precompile(Tuple{typeof(tuple_prod),Type{Tuple{3}}})
    Base.precompile(Tuple{typeof(tuple_prod),Type{Tuple{4}}})
    Base.precompile(Tuple{typeof(tuple_prod),Type{Tuple{5}}})
    Base.precompile(Tuple{typeof(tuple_prod),Type{Tuple{6}}})
end
