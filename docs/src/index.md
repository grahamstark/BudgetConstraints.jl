```@meta
CurrentModule = BudgetConstraints
```

#Piecewise Linear Budget Constraints

This generates a complete two-dimensional budget constraints for some unit
(person, benefit-unit, household, etc.) for some tax-benefit system. That is, a
list points describing the combinations of net income that the unit would get for different values of gross income (or hours worked, wages, etc.).

See: Duncan, Alan, and Graham Stark. "A Recursive Algorithm to Generate Piecewise Linear Budget Contraints" IFS Working Paper 2000/01 May 2, 2000] [https://doi.org/10.1920/wp.ifs.2000.0011](https://doi.org/10.1920/wp.ifs.2000.0011).


## Usage

Define a function that returns the net income for some gross value - this could be (e.g.) hours worked, wage, or gross income, and some set of data (details of a person, tax paramters, etc):

```julia
   function getnet( data::Dict, gross :: Real ) :: Real
```

 The call to `makebc` then generates the budget constraint using `getnet`. If successful this returns a BudgetConstraint array, which is a collection of `x,y` points describing all the points where the budget constraint has a change of slope, where `x` is the gross value and `y` the net.

The routine is controlled by a `BCSettings` struct; there is a `DEFAULT_SETTINGS` constant version of this which I suggest you don't change, apart from perhaps the upper and lower x-bounds of the graph.

```@index
```

## Functions and Data Structures

```@autodocs
Modules = [BudgetConstraints]
```

## Problems/TODO

* the tolerance isn't used consistently (see `nearlysameline`);
* I may be misunderstanding abstract types in the declarations;
* possibly use some definition of point, line, etc. from some standard package.
