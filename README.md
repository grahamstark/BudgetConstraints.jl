# Piecewise Linear Budget Constraints

This package can be used to generate a complete two-dimensional budget constraint for some unit
(person, benefit-unit, household, etc.) for some tax-benefit system. That is, a
list points describing the combinations of net income that the unit would get for different values of gross income (or hours worked, wages, etc.). The package takes a user-defined calculator function, and identifies all the points of discontinuity to a high degree of accuracy, even if the system being modelled has large discontinuities (as is common in fiscal systems).

[Here](https://stb.virtual-worlds.scot/bc-full.html) is a live example of this algorithm in action.

See:
Duncan, Alan, and Graham Stark. [A Recursive Algorithm to Generate Piecewise Linear Budget Contraints, IFS Working Paper 2000/01 May 2, 2000] (https://doi.org/10.1920/wp.ifs.2000.0011).

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://grahamstark.github.io/BudgetConstraints.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://grahamstark.github.io/BudgetConstraints.jl/dev)
[![Build Status](https://travis-ci.com/grahamstark/BudgetConstraints.jl.svg?branch=master)](https://travis-ci.com/grahamstark/BudgetConstraints.jl)
[![Coverage](https://codecov.io/gh/grahamstark/BudgetConstraints.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/grahamstark/BudgetConstraints.jl)
