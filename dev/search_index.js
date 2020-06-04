var documenterSearchIndex = {"docs":
[{"location":"#","page":"Home","title":"Home","text":"CurrentModule = BudgetConstraints","category":"page"},{"location":"#Piecewise-Linear-Budget-Constraints-1","page":"Home","title":"Piecewise Linear Budget Constraints","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"This generates a complete two-dimensional budget constraints for some unit (person, benefit-unit, household, etc.) for some tax-benefit system. That is, a list points describing the combinations of net income that the unit would get for different values of gross income (or hours worked, wages, etc.).","category":"page"},{"location":"#","page":"Home","title":"Home","text":"See: Duncan, Alan, and Graham Stark. \"A Recursive Algorithm to Generate Piecewise Linear Budget Contraints\" IFS Working Paper 2000/01 May 2, 2000] https://doi.org/10.1920/wp.ifs.2000.0011.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"Here is a live example of this algorithm in action.","category":"page"},{"location":"#Usage-1","page":"Home","title":"Usage","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Define a function that returns the net income for some gross value - this could be (e.g.) hours worked, wage, or gross income, and some set of data (details of a person, tax paramters, etc):","category":"page"},{"location":"#","page":"Home","title":"Home","text":"   function getnet( data::Dict, gross :: Real ) :: Real","category":"page"},{"location":"#","page":"Home","title":"Home","text":"The call to makebc then generates the budget constraint using getnet. If successful this returns a BudgetConstraint array, which is a collection of x,y points describing all the points where the budget constraint has a change of slope, where x is the gross value and y the net.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"The routine is controlled by a BCSettings struct; there is a DEFAULT_SETTINGS constant version of this which I suggest you don't change, apart from perhaps the upper and lower x-bounds of the graph.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Functions-and-Data-Structures-1","page":"Home","title":"Functions and Data Structures","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Modules = [BudgetConstraints]\n[:constant, :type, :function]","category":"page"},{"location":"#BudgetConstraints.DEFAULT_SETTINGS","page":"Home","title":"BudgetConstraints.DEFAULT_SETTINGS","text":"The tolerances here generally work quite well.\n\n\n\n\n\n","category":"constant"},{"location":"#BudgetConstraints.BCSettings","page":"Home","title":"BudgetConstraints.BCSettings","text":"settings for the calclation. Calculate over mingross to maxgross.\n\n\n\n\n\n","category":"type"},{"location":"#BudgetConstraints.BudgetConstraint","page":"Home","title":"BudgetConstraints.BudgetConstraint","text":"A budget constraint is then just an ordered list of points.\n\n\n\n\n\n","category":"type"},{"location":"#BudgetConstraints.annotate_bc-Tuple{Array{BudgetConstraints.Point2DG,1}}","page":"Home","title":"BudgetConstraints.annotate_bc","text":"This takes a budget constraint and produces a named tuple of METRs and Tax Credits for each one. (really just 1 minus the slope and the intercept at that point). Useful for annotating graphs and tables.\n\n\n\n\n\n","category":"method"},{"location":"#BudgetConstraints.censor","page":"Home","title":"BudgetConstraints.censor","text":"Attempt to remove near duplicate points and ensure all points ordered in ascending gross income.\n\n\n\n\n\n","category":"function"},{"location":"#BudgetConstraints.makebc","page":"Home","title":"BudgetConstraints.makebc","text":"Make a budget constraint using function getnet to extract net incomes and settings (see above on this struct). data should hold whatever your getnet function needs (parameters, a househols, etc.) getnet should be a function of the form net=f(data, gross). See the testcase for an example.\n\n\n\n\n\n","category":"function"},{"location":"#BudgetConstraints.pointstoarray-Tuple{Array{BudgetConstraints.Point2DG,1}}","page":"Home","title":"BudgetConstraints.pointstoarray","text":"Covert a list of points into x an y vectors. Some plotters may need this.\n\n\n\n\n\n","category":"method"},{"location":"#BudgetConstraints.Line2DG","page":"Home","title":"BudgetConstraints.Line2DG","text":"a line between 2 points; used internally\n\n\n\n\n\n","category":"type"},{"location":"#BudgetConstraints.Point2DG","page":"Home","title":"BudgetConstraints.Point2DG","text":"A point; in our case y is net income (or something) and x gross.\n\n\n\n\n\n","category":"type"},{"location":"#Problems/TODO-1","page":"Home","title":"Problems/TODO","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"the tolerance isn't used consistently (see nearlysameline);\nI may be misunderstanding abstract types in the declarations;\npossibly use some definition of point, line, etc. from some standard package.","category":"page"}]
}
