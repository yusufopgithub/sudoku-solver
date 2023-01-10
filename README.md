
# Pathfinding Visualizer

This is a simple implementation of a Sudoku solver in Dart using the Flutter framework. The solver uses a backtracking algorithm to fill in the missing digits of the Sudoku puzzle. The solve function starts by iterating through the puzzle and checking for empty spaces (indicated by a 0). When it finds an empty space, it tries each number from 1 to 9 and checks if it is a valid solution by calling the isValid function. If a valid solution is found, the function recursively continues solving the rest of the puzzle. If no valid solution is found, the function backtracks to the previous empty space and tries the next number. Once the puzzle is completely filled, the solved puzzle is printed to the console.

The isValid function checks if the current value is already present in the same row, column, or 3x3 grid of the puzzle. If the value is already present, the function returns false. Otherwise, it returns true.

The user interface is made with Flutter widgets, showing a grid of input fields on screen where users can input a sudoku question, when they press the solve button the sudoku is passed to the function to be solved.

