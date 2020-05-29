using BudgetConstraints
using MiniTB
using Test

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

    ps = BudgetConstraints.PointsSet([p1,p2,p3,p4,p5] )
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
