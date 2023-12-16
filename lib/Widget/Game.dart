import 'package:flutter/material.dart';
import 'package:flutter_application_1/Assest/my_color.dart';
import 'package:flutter_application_1/Assest/Styles.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> boxesval = ["", "", "", "", "", "", "", "", ""];
  bool TurnX = true;
  bool GameStart = true;
  bool Gameover = false;
  String result = '';
  List<int> winnerBoxes = [];
  int attempt = 0;
  int filledBoxes = 0;
  int xscore = 0;
  int yscore = 0;
  _GAMEOVER() {
    GameStart = false;
  }

// checks the combination
  _checkResult() {
    // Checking first row
    if (boxesval[0] == boxesval[1] &&
        boxesval[0] == boxesval[2] &&
        boxesval[0] != '') {
      setState(() {
        _setScore(boxesval[0]);
        winnerBoxes.addAll([0, 1, 2]);
        _GAMEOVER();
      });
      // Checking second row
    } else if (boxesval[3] == boxesval[4] &&
        boxesval[3] == boxesval[5] &&
        boxesval[3] != '') {
      setState(() {
        _setScore(boxesval[3]);
        winnerBoxes.addAll([3, 4, 5]);
         _GAMEOVER();
      });
      // Checking third row
    } else if (boxesval[6] == boxesval[7] &&
        boxesval[6] == boxesval[8] &&
        boxesval[6] != '') {
      setState(() {
         _GAMEOVER();
        _setScore(boxesval[6]);
        winnerBoxes.addAll([6, 7, 8]);
      });
      // Checking first column
    } else if (boxesval[0] == boxesval[3] &&
        boxesval[0] == boxesval[6] &&
        boxesval[0] != '') {
      setState(() {
        _setScore(boxesval[0]);
        winnerBoxes.addAll([0, 3, 6]);
         _GAMEOVER();
      });
    } else if (boxesval[1] == boxesval[4] &&
        boxesval[1] == boxesval[7] &&
        boxesval[1] != '') {
      setState(() {
        _setScore(boxesval[1]);
        winnerBoxes.addAll([1, 4, 7]);
         _GAMEOVER();
      });
    } else if (boxesval[2] == boxesval[5] &&
        boxesval[2] == boxesval[8] &&
        boxesval[2] != '') {
      setState(() {
         _GAMEOVER();
        _setScore(boxesval[2]);
        winnerBoxes.addAll([2, 5, 8]);
      });
    } else if (boxesval[0] == boxesval[4] &&
        boxesval[0] == boxesval[8] &&
        boxesval[0] != '') {
      setState(() {
        _setScore(boxesval[0]);
        winnerBoxes.addAll([0, 4, 8]);
         _GAMEOVER();
      });
    } else if (boxesval[2] == boxesval[4] &&
        boxesval[2] == boxesval[6] &&
        boxesval[2] != '') {
      setState(() {
        _setScore(boxesval[2]);
        winnerBoxes.addAll([2, 4, 6]);
         _GAMEOVER();
      });
    } else {
      if (filledBoxes >= 9) {
        setState(() {
          result = 'Game Drawn!';
        });
      }
    }
    attempt++;
  }

  _setScore(String winner) {
    if (winner == 'X') {
      setState(() {
        xscore++;
        result = 'Player $winner Wins!';

      });
    } else {
      setState(() {
        yscore++;
        result = 'Player $winner Wins!';
      
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _Tapped(int index) {
      if (GameStart) {
        setState(() {
          if (boxesval[index] == "" && TurnX == true) {
            boxesval[index] = "X";
            TurnX = !TurnX;
            filledBoxes++;
          }
          if (boxesval[index] == "" && TurnX == false) {
            boxesval[index] = "Y";
            TurnX = !TurnX;
            filledBoxes++;
          }
          _checkResult();
        });
      }
    }

    _reset() {
      setState(() {
        boxesval.fillRange(0, 9, '');

        Gameover = false;
        result = '';
        winnerBoxes = [];
        filledBoxes = 0;
      });
    }

    _startGame() {
      GameStart = true;
      _reset();
    }

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("Player 1", style: Styles.txtStyle),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(xscore.toString(), style: Styles.txtStyle),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text("Player 2", style: Styles.txtStyle),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(yscore.toString(), style: Styles.txtStyle),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _Tapped(index);
                    },
                    child: Container(
                      color: ColorConstants.secondaryColor,
                      child: Text(
                        boxesval[index],
                        style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      margin: EdgeInsets.all(5),
                      alignment: Alignment(0.1, 0.1),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Text(
                result,
                style: Styles.txtStyle,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  TextButton(
                    onPressed: _startGame,
                    style: TextButton.styleFrom(
                      backgroundColor: ColorConstants.secondaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                    child: Text(
                      attempt > 0 ? " Play Again" : " Start Play ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
