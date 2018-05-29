from __future__ import print_function
from ortools.linear_solver import pywraplp

def main():
    """Solving Assignment Problem with MIP"""
    # Instantiate a mixed-integer solver.
    solver = pywraplp.Solver('SolveAssignmentProblemMIP', pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)

    nodes = ["a", "b", "c"]
    demand = [5, -2, -3]
    cost = [[0, 2, 2],
            [2, 0, 1],
            [2, 1, 0]]

    num_nodes = len(nodes)
    x = {}

    A = {"a": ["b", "c"], "b": ["a", "c"], "c": ["a", "b"]}

    for i in range(num_nodes):
        for j in range(num_nodes):
            x[i, j] = solver.NumVariables()

    solver.Minimize(solver.Sum([cost[i][j] * x[i, j] for i in range(num_nodes) for j in range(num_nodes)]))

    # Constraints

    # Kirchhoff's current law
    for key in A.keys():
        print (demand[nodes.index(key)])
        for connection in A[key]:
            print (x[nodes.index(key), nodes.index(connection)])
        solver.Add(solver.Sum(x[nodes.index(key), nodes.index(connection)] for connection in A[key]) == demand[nodes.index(key)])

    sol = solver.Solve()

    print('Total cost = ', solver.Objective().Value())
    print()












def old():
  """Solving Assignment Problem with MIP"""
  # Instantiate a mixed-integer solver.
  solver = pywraplp.Solver('SolveAssignmentProblemMIP',
                           pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)
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
  solver.Minimize(solver.Sum([cost[i][j] * x[i,j] for i in range(num_workers)
                                                  for j in range(num_tasks)]))

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

  print('Total cost = ', solver.Objective().Value())
  print()
  for i in range(num_workers):
    for j in range(num_tasks):
      if x[i, j].solution_value() > 0:
        print('Worker %d assigned to task %d.  Cost = %d' % (
              i,
              j,
              cost[i][j]))

  print()
  print("Time = ", solver.WallTime(), " milliseconds")

if __name__ == '__main__':
  main()