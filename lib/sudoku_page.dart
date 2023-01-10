import 'dart:core';

import 'package:flutter/material.dart';

class Sudoku extends StatefulWidget {
  const Sudoku({Key? key}) : super(key: key);

  @override
  State<Sudoku> createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {

  List<List<int>> sudoku = [
    [0, 0, 0, 2, 6, 0, 7, 0, 1],
    [6, 8, 0, 0, 7, 0, 0, 9, 0],
    [1, 9, 0, 0, 0, 4, 5, 0, 0],
    [8, 2, 0, 1, 0, 0, 0, 4, 0],
    [0, 0, 4, 6, 0, 2, 9, 0, 0],
    [0, 5, 0, 0, 0, 3, 0, 2, 8],
    [0, 0, 9, 3, 0, 0, 0, 7, 4],
    [0, 4, 0, 0, 5, 0, 0, 3, 6],
    [7, 0, 3, 0, 1, 8, 0, 0, 0]
  ];

  bool solve(List<List<int>> sudoku) {
    int rows = 9;
    int cols = 9;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (sudoku[row][col] == 0) {
          for (int n = 1; n < 10; n++) {
            sudoku[row][col] = n;
            if (isValid(sudoku, row, col) && solve(sudoku)) {
              return true;
            }
            sudoku[row][col] = 0;
          }
          return false;
        }
      }
    }
    print("Solved Sudoku:");
    for (int row = 0; row < rows; row++) {
      print(sudoku[row]);
    }
    return true;
  }

  bool isValid(List<List<int>> sudoku, int row, int col) {
    // Check if the value is already present in the same row
    for (int i = 0; i < 9; i++) {
      if (sudoku[row][i] == sudoku[row][col] && i != col) {
        return false;
      }
    }

    // Check if the value is already present in the same column
    for (int i = 0; i < 9; i++) {
      if (sudoku[i][col] == sudoku[row][col] && i != row) {
        return false;
      }
    }

    // Check if the value is already present in the same 3x3 grid
    int gridX = col ~/ 3;
    int gridY = row ~/ 3;

    for (int i = 3 * gridY; i < 3 * gridY + 3; i++) {
      for (int j = 3 * gridX; j < 3 * gridX + 3; j++) {
        if (sudoku[i][j] == sudoku[row][col] && (i != row || j != col)) {
          return false;
        }
      }
    }

    return true;
  }





  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    return Scaffold(
      backgroundColor: Color.fromRGBO(176, 100, 100, 1.0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Color.fromRGBO(176, 100, 100, 1.0),
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0),
            child: Text("sudoku solver"),
          ),
          leadingWidth: 150,

        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: width,
              height: 370,
              color: Colors.transparent,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 9,
                children: List.generate(81, (index) {
                  int row = index ~/ 9;
                  int col = index % 9;
                  int value = sudoku[row][col];
                  int group = (row ~/ 3) * 3 + (col ~/ 3);
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: (group % 2 == 0) ? Colors.cyan :Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: value == 0 ? null : Text("$value", style: TextStyle(fontSize: 30)),
                  );
                }),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sudoku = [
                          [0, 0, 0, 2, 6, 0, 7, 0, 1],
                          [6, 8, 0, 0, 7, 0, 0, 9, 0],
                          [1, 9, 0, 0, 0, 4, 5, 0, 0],
                          [8, 2, 0, 1, 0, 0, 0, 4, 0],
                          [0, 0, 4, 6, 0, 2, 9, 0, 0],
                          [0, 5, 0, 0, 0, 3, 0, 2, 8],
                          [0, 0, 9, 3, 0, 0, 0, 7, 4],
                          [0, 4, 0, 0, 5, 0, 0, 3, 6],
                          [7, 0, 3, 0, 1, 8, 0, 0, 0]
                        ];
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white30),
                    child: const Text("reset"),
                  )),
              SizedBox(width: 10,),
              Container(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      if (solve(sudoku)) {
                        setState(() {
                          sudoku = sudoku;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white30),
                    child: const Text("solve"),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
