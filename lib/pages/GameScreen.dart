import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../module/GameLogic.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameLogic = Get.put(MyGame());

  @override
  Widget build(BuildContext context) {
    print(GameLogic.mySnake);

    return Column(
      children: [
        Obx(
          () => Container(
            height: 480,
            width: double.infinity,
            child: GridView.builder(
              itemCount: GameLogic.gameField.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9,
              ),
              itemBuilder: (context, index) {
                return game(index);
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: ElevatedButton(
            onPressed: () {
              if (GameLogic.play.value == true) {
                GameLogic.play.value = false;
                GameLogic.startGame();
              }
            },
            child: Text("Start game"),
          ),
        ),
      ],
    );
  }

  game(fieldIndex) {
    return Obx(
      () => GestureDetector(
        onVerticalDragUpdate: ((details) {

          if (details.delta.dy < 0) {
            GameLogic.prevRoot.value = GameLogic.snakeRoot.value;
            if (GameLogic.snakeRoot.value != Directions.BOTTOM) {
              GameLogic.snakeRoot.value = Directions.UP;
            }
          } else {
            GameLogic.prevRoot.value = GameLogic.snakeRoot.value;
            if (GameLogic.snakeRoot.value != Directions.UP) {
              GameLogic.snakeRoot.value = Directions.BOTTOM;
            }
          }
        }),
        onHorizontalDragUpdate: (details) {
          
          if (details.delta.dx > 0) {
            GameLogic.prevRoot.value = GameLogic.snakeRoot.value;
            if (GameLogic.snakeRoot.value != Directions.LEFT) {
              GameLogic.snakeRoot.value = Directions.RIGHT;
            }
          } else {
            GameLogic.prevRoot.value = GameLogic.snakeRoot.value;
            if (GameLogic.snakeRoot.value != Directions.RIGHT) {
              GameLogic.snakeRoot.value = Directions.LEFT;
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: GameLogic.mySnake.contains(fieldIndex)
                ? Colors.red
                : fieldIndex == GameLogic.food
                    ? Colors.green
                    : Colors.white,
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
        ),
      ),
    );
  }
}
