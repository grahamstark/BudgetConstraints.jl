using Parameters
#
# A toy tax-benefit system with outlines of the components
# a real model would need: models of people (and households)
# a parameter system, a holder for results, and some calculations
# using those things.
# Used in test building budget constraints.
#

@enum Gender Male Female


const DEFAULT_HOURS = 30
const DEFAULT_WAGE = 5.0
const DEFAULT_AGE = 50

"""

A very simple model of a person with age, hours, income.

"""
@with_kw mutable struct Person
   pid::BigInt = 1
   wage::Number = DEFAULT_WAGE
   hours::Number = DEFAULT_HOURS
   income::Number = DEFAULT_HOURS*DEFAULT_WAGE
   age::Integer = DEFAULT_AGE
   sex::Gender = Male
end

function weeklyise( x :: Number ) :: Number
   x / (365.25/7)
end

"""

Struct with tax rates and bands, and the levels and withdrawal rates
for our benefits.

"""
@with_kw mutable struct MiniParams
   it_allow = weeklyise(12_500.0)
   it_rate = [0.20, 0.4]
   it_band = [weeklyise(50_000), 9999999999999999999.99]
   benefit1 = 73.00
   benefit2 = 101.0 # weeklyise( 1_960.0+ 545+2_780.0),
   ben2_min_hours = 30.0
   ben2_taper = 0.41
   ben2_u_limit = 123.00
   basic_income = 0.0
end

const ZERO_PARAMS = MiniParams(
   it_allow = 0.0,
   it_rate = [0.0,0.0],
   it_band = [weeklyise(50_000), 9999999999999999999.99],
   benefit1 = 0.0,
   benefit2 = 0.0, # weeklyise( 1_960.0+ 545+2_780.0),
   ben2_min_hours = 0.0,
   ben2_taper = 0.0,
   ben2_u_limit = 0.0,
   basic_income = 0.0
)

"""

An over-engineered rate/band calculation.

"""
function calctaxdue( ;
   taxable::Number,
   rates::Vector,
   thresholds::Vector) :: Number
   nthresholds = length(thresholds)[1]
   nrates = length(rates)[1]

   @assert (nrates >= 1) && ((nrates - nthresholds) in 0:1 ) # allow thresholds to be 1 less & just fill in the top if we need it
   due = 0.0
   mr  = 0.0
   remaining = taxable
   i = 0
   if nthresholds > 0
      maxv = typemax( typeof( thresholds[1] ))
      gap = thresholds[1]
   else
      maxv = typemax( typeof( taxable ))
      gap = maxv
   end
   while remaining > 0.0
      i += 1
      if i > 1
         if i < nrates
            gap = thresholds[i]-thresholds[i-1]
         else
            gap = maxv
         end
      end
      t = min( remaining, gap )      # println( "got gap as $gap remaining $remaining")
      due += t*rates[i]
      remaining -= gap
   end
   due
end

const Results = Dict{Symbol,Any}

"""

Income Tax - taxable only above some allowance, at rates/bands

"""
function calculatetax(pers::Person, params::MiniParams)::Float64
   taxable = max(0.0, pers.income - params.it_allow)
   return calctaxdue(
      taxable    = taxable,
      rates      = params.it_rate,
      thresholds = params.it_band,
   )
end

"""

An income support type min-income benefit, withdrawn at 100%

"""
function calculatebenefit1(pers::Person, params::MiniParams)::Float64
   ben = params.benefit1 - pers.income
   return max(0.0, ben )
end

"""

A Working Tax Credit/UC type benefit, paid only if hours exceed some
limit and withdrawn above an income limit at `taper` rate.

"""
function calculatebenefit2(pers::Person, params::MiniParams)::Float64
   b = pers.hours >= params.ben2_min_hours ? params.benefit2 : 0.0
   if pers.income > params.ben2_u_limit
      b = max(0.0, b - (params.ben2_taper * (pers.income - params.ben2_u_limit)))
   end
   return b
end


"""
    calculate(pers::Person,params::MiniParams)

All the results from our mini-system for one person.

"""
function calculate(pers::Person, params::MiniParams)::Results
   res = Results()
   res[:tax] = calculatetax(pers, params)
   res[:benefit1] = calculatebenefit1(pers, params)
   res[:benefit2] = calculatebenefit2(pers, params)
   res[:basic_income] = params.basic_income

   res[:netincome] = pers.income + res[:benefit1] + res[:benefit2]+res[:basic_income] - res[:tax]
   return res
end
