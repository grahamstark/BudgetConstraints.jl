using BudgetConstraints

using Test

include("mini_tb_sys.jl")


# @test size( ps ) == 4
function test_getnet( data :: Dict, gross :: Float64 ) :: Float64
     person = data[:person]
     person.income = gross
     person.hours = gross/person.wage
     rc = calculate( person, data[:params] )
     return rc[:netincome]
end


function make_one_bc( person :: Person, params :: MiniParams ) :: BudgetConstraint
    data = Dict(
        :person=>person,
        :params=>params )
    bc = BudgetConstraints.makebc( data, test_getnet )
    return bc

end

@testset "reverse lookup thing" begin
    x1 = Point2D(0,10) # 100%
    x2 = Point2D(10,10) # 100%
    x3 = Point2D(20,20)  # 0%
    x4 = Point2D(40,30)  # 50%
    x5 = Point2D(100,45) # 75%
    bc = [x1,x2,x3,x4,x5]
    yn = get_x_from_y(bc,0.0) # some abitrary number between 0 and 10
    @test 0.0 >= yn <= 10.0

    yn = get_x_from_y(bc,11.0) # 0 mr so gross=net
    @test yn ≈ 11.0

    yn = get_x_from_y(bc,21.0) # 50% mr so 20 + 2
    @test yn ≈ 22.0

    yn = get_x_from_y(bc,31.0) # 75% mr so 40 + 4
    @test yn ≈ 44.0

end

@testset "BudgetConstraints.jl" begin

    using Test

    # @testset begin
     p1 = Point2D( 1.011,2.011)
     p2 = Point2D( 1.011, 2.011 )
     p3 = Point2D( 1.011, 3.011 )
     p4 = Point2D( -1.011, -3.011 )
     p5 = Point2D( 10.011, 13.011 )

     bc = BudgetConstraint( [p1,p2,p3,p4,p5])

    sort!( bc )

    @test size( bc )[1] == 5

    ps = Set([p1,p2,p3,p4,p5] )
    push!( ps, p1 )
    push!( ps, p2 )
    push!( ps, p3 )
    push!( ps, p4 )
    push!( ps, p5 )
    println( "ps = $ps ")
    push!( ps, Point2D( 1.0011, 1.999999 ))

    bc2 = censor( ps )

    println( "bc2 = $bc2 ")
    @test size( bc2 )[1] == 5
    pers = Person()
    pars = deepcopy(MiniParams())
    res = calculate( pers, pars )
    println( "res=$res" )


    bc = make_one_bc( Person(), MiniParams() )
    println( "\nDefault Case\n")
    println(BudgetConstraints.pointstoarray( bc))
    annotations = annotate_bc( bc )
    println( annotations )


    bc = make_one_bc( Person(), ZERO_PARAMS )
    println( "\nZero Params\n")
    println( BudgetConstraints.pointstoarray( bc))
    annotations = annotate_bc( bc )
    println( annotations )

    person = deepcopy(Person())
    # rc = calculate( Person(), pars )
    pars999 = MiniParams()
    pars999.it_allow = 999.0

    println( "\n999 allowance case\n")
    bc = make_one_bc( person, pars999 )
    println( BudgetConstraints.pointstoarray( bc ))
    annotations = annotate_bc( bc )
    println( annotations )



end
