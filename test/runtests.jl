using PenaltiesLH
using Test

# Scalar penalty functions can accept multiple arguments.
scalar_test_fct(x, y) = sum(x) + sum(y);

function make_test_penalty(pName :: Symbol; isUsed :: Bool = true)
    return Penalty(name = pName,  isUsed = isUsed,  
        scalarFct = scalar_test_fct, scalarValue = 0.0);
end

function make_test_penalty_vector(n :: Integer)
    pv = PenaltyVector(n);
    for j = 1 : n
        pv[j] = make_test_penalty(Symbol("p$j"), isUsed = iseven(j));
    end
    return pv
end


function penalty_test()
    @testset "Penalty" begin
        p = make_test_penalty(:p1);
        @test name(p) == :p1
        @test scalar_value(p) == 0.0
        set_scalar_value(p, 2.0)
        @test scalar_value(p) == 2.0
        show(p)

        x = [1.0, 2.0];
        y = [4.3, 2.9];
        # Need to package multiple arguments into a tuple
        sv = compute_penalty(p, (x,y));
        @test scalar_value(p) == sv
    end
end


function pvector_test()
    @testset "PenaltyVector" begin
        n = 7;
        pv = make_test_penalty_vector(n);
        @test length(pv) == n
        @test !isempty(pv)
        for j = 1 : n
            p = pv[j];
            @test isa(p, Penalty)
        end

        j = 0
        for p in pv
            j += 1
            @test isa(p, Penalty)
        end
        @test j == n

        p = retrieve(pv, :p3);
        @test name(p) == :p3
        p = retrieve(pv, :pp3);
        @test isnothing(p)

        pName = :pPushed;
        p7 = make_test_penalty(pName);
        push!(pv, p7);
        @test length(pv) == n+1
        p = retrieve(pv, pName);
        @test name(p) == pName

        d = penalty_dict(pv);
        for p in pv
            if PenaltiesLH.is_used(p)
                @test haskey(d, name(p))
            else
                @test !haskey(d, name(p))
            end
        end

        use(pv, :p3);
        @test is_used(pv, :p3)
        no_use(pv, :p3)
        @test !is_used(pv, :p3)

        # Computing penalties
        x = [3.4, 4.5];
        y = [9.2, 0.8];
        pTotal = total_penalty(pv, data = (x, y));
        compute_all_penalties(pv, (x, y));
        pTotal2 = total_penalty(pv, data = (x, y));
        @test pTotal ≈ pTotal2

        report_penalties(pv)
    end
end


@testset "PenaltiesLH" begin
    penalty_test()
    pvector_test()
end

# ---------
