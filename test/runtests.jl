using BudgetConstraints
using MiniTB
using Test

# @test size( ps ) == 4
function getnet( data :: Dict, gross :: Float64 ) :: Float64
     person = data[:person]
     person.wage = gross
     person.hours = gross/DEFAULT_WAGE
     rc = calculate( person, data[:params] )
     return rc[:netincome]
end


function makebc( person :: Person, params :: MiniParams ) :: BudgetConstraint
    data = Dict(
        :person=>person,
        :params=>params )
    bc = makebc( data, getnet )
    return bc
end



@testset "BudgetConstraints.jl" begin

    using Test
    using MiniTB

    # @testset begin
     p1 = Point2D( 1.011,2.011)
     p2 = Point2D( 1.011, 2.011 )
     p3 = Point2D( 1.011, 3.011 )
     p4 = Point2D( -1.011, -3.011 )
     p5 = Point2D( 10.011, 13.011 )

     bc = BudgetConstraint( [p1,p2,p3,p4,p5])

    sort!( bc )

    @test size( bc )[1] == 5

    ps = PointsSet([p1,p2,p3,p4,p5] )
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


    bc = makebc( DEFAULT_PERSON, DEFAULT_PARAMS )
    println( "\nDefault Case\n")
    println(pointstoarray( bc))
    annotations = annotate_bc( bc )
    println( annotations )


    bc = makebc( DEFAULT_PERSON, ZERO_PARAMS )
    println( "\nZero Params\n")
    println( pointstoarray( bc))
    annotations = annotate_bc( bc )
    println( annotations )

    person = deepcopy(DEFAULT_PERSON)
    # rc = calculate( DEFAULT_PERSON, pars )
    pars999 = deepcopy(DEFAULT_PARAMS)
    pars999.it_allow = 999.0

    println( "\n999 allowance case\n")
    bc = makebc( person, pars999 )
    println( pointstoarray( bc ))
    annotations = annotate_bc( bc )
    println( annotations )


end
