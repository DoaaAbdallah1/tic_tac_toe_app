import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_item.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  final String mySymbol;
  const HomeScreen({super.key, required this.mySymbol});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> itemSymbols = ["", "", "", "", "", "", "", "", ""];
  int counter = 0;
  int scorePlayer1 = 0;
  int scorePlayer2 = 0;
  bool isTimeFinished = false;
  late DateTime endTime;
  bool showTimer = true;
  int timerVersion = 0;

  @override
  void initState() {
    super.initState();
    endTime = DateTime.now().add(const Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: .spaceBetween,
              spacing: 16,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(44),
                  ),
                  child: Column(
                    spacing: 16,
                    children: [
                      CupertinoPageScaffold(
                        backgroundColor: Colors.transparent,

                        child: (showTimer)
                            ? TimerCountdown(
                                endTime: endTime,
                                format: CountDownTimerFormat.minutesSeconds,
                                timeTextStyle: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                colonsTextStyle: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                enableDescriptions: false,
                                onEnd: () {
                                  if (!mounted || isTimeFinished) return;

                                  setState(() {
                                    isTimeFinished = true;
                                  });

                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return CustomDialog(
                                        title: "Time's Up!",
                                        description:
                                            'You ran out of time. Try again!',
                                        imagePath: AppAssets.lossGame,
                                        buttonText: 'Try Again',
                                        onTap: () {
                                          Navigator.pop(context);
                                          initGame();
                                        },
                                      );
                                    },
                                  );
                                },
                              )
                            : SizedBox.shrink(),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Player 1(${widget.mySymbol})\nScore : $scorePlayer1",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: .w700,
                                color: AppColors.black,
                              ),
                              textAlign: .center,
                            ),
                          ),

                          Flexible(
                            child: Text(
                              "Player 2(${widget.mySymbol == "x" ? "o" : "x"})\nScore : $scorePlayer2",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: .w700,
                                color: AppColors.black,
                              ),
                              textAlign: .center,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        'First to 3 points wins!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              Flexible(
                child: Column(
                  mainAxisAlignment: .end,
                  children: [
                      Text(
                    counter % 2 == 1 ? "Player 2’s Turn" : "Player 1’s Turn",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: .w700,
                      color: AppColors.white,
                    ),
                    textAlign: .center,
                  ),
                
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(44),
                      ),
                      child: GridView.builder(
                        itemCount: 9,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              childAspectRatio: 0.8
                            
                            ),
                        itemBuilder: (context, index) => CustomItem(
                          symbol: itemSymbols[index],
                          index: index,
                          onTap: () {
                            if (isTimeFinished) return;
                            if (itemSymbols[index] == '') {
                              if (counter % 2 == 0) {
                                itemSymbols[index] = widget.mySymbol;
                              } else {
                                itemSymbols[index] = widget.mySymbol == "x"
                                    ? "o"
                                    : "x";
                              }
                              counter++;
                              if (isWinner("x")) {
                                if (widget.mySymbol == "x") {
                                  scorePlayer1++;
                                } else {
                                  scorePlayer2++;
                                }
                                checkScore();
                                Future.delayed(Duration(seconds: 1), resetGame);
                              }
                              if (isWinner("o")) {
                                if (widget.mySymbol == "o") {
                                  scorePlayer1++;
                                } else {
                                  scorePlayer2++;
                                }
                                checkScore();
                                Future.delayed(Duration(seconds: 1), resetGame);
                              }
                        
                              if (counter == 9) {
                                Future.delayed(Duration(seconds: 1), resetGame);
                              }
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                
                  ],
                ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isWinner(String mySymbol) {
    for (int i = 0; i < 3; i++) {
      if (itemSymbols[i] == mySymbol &&
          itemSymbols[i + 3] == mySymbol &&
          itemSymbols[i + 6] == mySymbol) {
        return true;
      }
      if (itemSymbols[i * 3] == mySymbol &&
          itemSymbols[i * 3 + 1] == mySymbol &&
          itemSymbols[i * 3 + 2] == mySymbol) {
        return true;
      }
    }
    if (itemSymbols[0] == mySymbol &&
        itemSymbols[4] == mySymbol &&
        itemSymbols[8] == mySymbol) {
      return true;
    }
    if (itemSymbols[2] == mySymbol &&
        itemSymbols[4] == mySymbol &&
        itemSymbols[6] == mySymbol) {
      return true;
    }

    return false;
  }

  void resetGame() {
    setState(() {
      itemSymbols = List.filled(9, '');
      counter = 0;
      //  endTime = DateTime.now().add(const Duration(seconds: 30));
      isTimeFinished = false;
      // scorePlayer1 = 0;
      // scorePlayer2 = 0;
    });
  }

  void initGame() {
    setState(() {
      itemSymbols = List.filled(9, '');
      counter = 0;
      scorePlayer1 = 0;
      scorePlayer2 = 0;
      isTimeFinished = false;
    });

    restartTimer();
  }

  Future<void> restartTimer() async {
    setState(() {
      showTimer = false;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted) return;

    setState(() {
      endTime = DateTime.now().add(const Duration(seconds: 30));
      isTimeFinished = false;
      showTimer = true;
    });
  }

  void checkScore() {
    if (scorePlayer1 == 3 || scorePlayer2 == 3) {
      final winner = scorePlayer1 == 3 ? "Player 1" : "Player 2";

      setState(() {
        isTimeFinished = true;
        showTimer = false;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialog(
            title: 'Congratulations!',
            description: '$winner is the Champion!',
            imagePath: AppAssets.winGame,
            buttonText: 'Play Again',
            onTap: () {
              Navigator.pop(context);
              initGame();
            },
          );
        },
      );
    }
  }
}
