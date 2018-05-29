"""
    Example problem file that solves the whiskas blending problem
"""
import pulp
def cat():
    #initialise the model
    whiskas_model = pulp.LpProblem("The Whiskas Problem", pulp.LpMinimize)
    # make a list of ingredients
    ingredients = ["chicken", "beef", "mutton", "rice", "wheat", "gel"]
    # create a dictionary of pulp variables with keys from ingredients
    # the default lower bound is -inf
    x = pulp.LpVariable.dict("x_%s", ingredients, lowBound =0)
    # cost data
    cost = dict(zip(ingredients, [0.013, 0.008, 0.010, 0.002, 0.005, 0.001]))
    # create the objective
    whiskas_model += sum( [cost[i] * x[i] for i in ingredients])
    # ingredient parameters
    protein = dict(zip(ingredients, [0.100, 0.200, 0.150, 0.000, 0.040, 0.000]))
    fat = dict(zip(ingredients, [0.080, 0.100, 0.110, 0.010, 0.010, 0.000]))
    fibre = dict(zip(ingredients, [0.001, 0.005, 0.003, 0.100, 0.150, 0.000]))
    salt = dict(zip(ingredients, [0.002, 0.005, 0.007, 0.002, 0.008, 0.000]))
    #note these are constraints and not an objective as there is a equality/inequality
    whiskas_model += sum([protein[i]*x[i] for i in ingredients]) >= 8.0
    whiskas_model += sum([fat[i]*x[i] for i in ingredients]) >= 6.0
    whiskas_model += sum([fibre[i]*x[i] for i in ingredients]) <= 2.0
    whiskas_model += sum([salt[i]*x[i] for i in ingredients]) <= 0.4
    #problem is then solved with the default solver
    whiskas_model.solve()
    #print the result
    for ingredient in ingredients:
        print "The mass of %s is %s grams per can" %(ingredient, x[ingredient].value())

def beer():
    """
    The Beer Distribution Problem for the PuLP Modeller
    Authors: Antony Phillips, Dr Stuart Mitchell 2007
    """
    # Creates a list of all the supply nodes
    warehouses = ["A", "B"]

    # Creates a dictionary for the number of units of supply for each supply node
    supply = {"A": 1000, "B": 4000}

    # Creates a list of all demand nodes
    bars = ["1", "2", "3", "4", "5"]

    # Creates a dictionary for the number of units of demand for each demand node
    demand = {"1": 500, "2":900, "3":1800, "4":200, "5":700,}

    # Creates a list of costs of each transportation path
    costs = [  # Bars # 1 2 3 4 5
        [2, 4, 5, 2, 1],    # A Warehouses
        [3, 1, 3, 2, 3]     # B
        ]

    # Fixed Transportation cost
    fixedCosts = [  # Bars # 1 2 3 4 5
        [20000, 20000, 20000, 20000, 20000],    # A Warehouses
        [0, 0, 0, 0, 0]     # B
        ]

    # The cost data is made into a dictionary
    costs = pulp.makeDict([warehouses, bars], costs, 0)

    # The cost data is made into a dictionary
    fixedCosts = pulp.makeDict([warehouses, bars], fixedCosts, 0)

    # Creates the prob variable to contain the problem data
    prob = pulp.LpProblem("Beer Distribution Problem", pulp.LpMinimize)

    # Creates a list of tuples containing all the possible routes for transport
    routes = [(w, b) for w in warehouses for b in bars]

    # A dictionary called x is created to contain quantity shipped on the routes
    x = pulp.LpVariable.dicts("route", (warehouses, bars), lowBound = 0, cat = pulp.LpInteger)

    # The objective function is added to prob first
    prob += sum([((x[w][b] * costs[w][b]) + fixedCosts[w][b]) for (w, b) in routes]), "Sum_of_Transporting_Costs"

    # Supply maximum constraints are added to prob for each supply node (warehouse)
    for w in warehouses:
        prob += sum([x[w][b] for b in bars]) <= supply[w], "Sum_of_Products_out_of_Warehouse_%s" % w

    # Demand minimum constraints are added to prob for each demand node (bar)
    for b in bars:
        prob += sum([x[w][b] for w in warehouses]) >= demand[b], \
        "Sum_of_Products_into_Bar%s" % b

    # The problem data is written to an .lp file
    prob.writeLP("BeerDistributionProblem.lp")

    # The problem is solved using PuLP's choice of Solver
    prob.solve()

    # The status of the solution is printed to the screen
    print "Status:", pulp.LpStatus[prob.status]

    # Each of the variables is printed with it's resolved optimum value
    for v in prob.variables():
        print v.name, "=", v.varValue

    # The optimised objective function value is printed to the screen
    print "Total Cost of Transportation = ", prob.objective.value()


def tasksJVR():

    from ortools.linear_solver import pywraplp
    """Solving Assignment Problem with MIP"""
    # Instantiate a mixed-integer solver.
    solver = pywraplp.Solver('SolveAssignmentProblemMIP', pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)

    cost = [[90, 76, 75, 70],
            [35, 85, 55, 65],
            [125, 95, 90, 105],
            [45, 110, 95, 115],
            [60, 105, 80, 75],
            [45, 65, 110, 95]]

    team1 = [0, 2, 4]
    team2 = [1, 3, 5]
    team_max = 2

    num_workers = len(cost)
    num_tasks = len(cost[1])
    x = {}

    for i in range(num_workers):
        for j in range(num_tasks):
            x[i, j] = solver.BoolVar('x[%i,%i]' % (i, j))


    # Objective
    solver.Minimize(solver.Sum([cost[i][j] * x[i, j] for i in range(num_workers) for j in range(num_tasks)]))

    # Constraints

    # Each worker is assigned to at most 1 task.

    for i in range(num_workers):
        solver.Add(solver.Sum([x[i, j] for j in range(num_tasks)]) <= 1)

    # Each task is assigned to exactly one worker.

    for j in range(num_tasks):
        solver.Add(solver.Sum([x[i, j] for i in range(num_workers)]) == 1)

    # Each team takes on two tasks.

    solver.Add(solver.Sum([x[i, j] for i in team1 for j in range(num_tasks)]) <= team_max)
    solver.Add(solver.Sum([x[i, j] for i in team2 for j in range(num_tasks)]) <= team_max)
    sol = solver.Solve()

    print 'Total cost = ', solver.Objective().Value()
    print ""
    for i in range(num_workers):
        for j in range(num_tasks):
            if x[i, j].solution_value() > 0:
                print('Worker %d assigned to task %d.  Cost = %d' % (
                    i,
                    j,
                    cost[i][j]))

    print
    print "Time = ", solver.WallTime(), " milliseconds"

    def tasks():

        from ortools.linear_solver import pywraplp
        """Solving Assignment Problem with MIP"""
        # Instantiate a mixed-integer solver.
        solver = pywraplp.Solver('SolveAssignmentProblemMIP', pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)

        cost = [[90, 76, 75, 70],
                [35, 85, 55, 65],
                [125, 95, 90, 105],
                [45, 110, 95, 115],
                [60, 105, 80, 75],
                [45, 65, 110, 95]]

        team1 = [0, 2, 4]
        team2 = [1, 3, 5]
        team_max = 2

        num_workers = len(cost)
        num_tasks = len(cost[1])
        x = {}

        for i in range(num_workers):
            for j in range(num_tasks):
                x[i, j] = solver.BoolVar('x[%i,%i]' % (i, j))
                print x[i, j]
                print cost[i][j]
                print cost[i][j] * x[i, j]

        # Objective
        solver.Minimize(solver.Sum([cost[i][j] * x[i, j] for i in range(num_workers) for j in range(num_tasks)]))

        # Constraints

        # Each worker is assigned to at most 1 task.

        for i in range(num_workers):
            solver.Add(solver.Sum([x[i, j] for j in range(num_tasks)]) <= 1)

        # Each task is assigned to exactly one worker.

        for j in range(num_tasks):
            solver.Add(solver.Sum([x[i, j] for i in range(num_workers)]) == 1)

        # Each team takes on two tasks.

        solver.Add(solver.Sum([x[i, j] for i in team1 for j in range(num_tasks)]) <= team_max)
        solver.Add(solver.Sum([x[i, j] for i in team2 for j in range(num_tasks)]) <= team_max)
        sol = solver.Solve()

        print 'Total cost = ', solver.Objective().Value()
        print ""
        for i in range(num_workers):
            for j in range(num_tasks):
                if x[i, j].solution_value() > 0:
                    print('Worker %d assigned to task %d.  Cost = %d' % (
                        i,
                        j,
                        cost[i][j]))

        print
        print "Time = ", solver.WallTime(), " milliseconds"

tasksJVR()