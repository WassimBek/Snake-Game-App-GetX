import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

enum Directions { UP, BOTTOM, LEFT, RIGHT }

class MyGame extends GetxController {
  List<int> gameField = List.generate(99, (index) => index).obs;
  List<int> mySnake = List.generate(3, (index) => index).obs;
  Rx<Directions> snakeRoot = Directions.RIGHT.obs;
  Rx<Directions> prevRoot = Directions.RIGHT.obs;
  RxBool play = true.obs;
  int Row = 9;
  int col = 11;
  RxInt userRate = 0.obs;
  var food = Random().nextInt(99);

  void startGame() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      Game();
      if (loseGame(mySnake.last)) {
        timer.cancel();
        gameField = List.generate(99, (index) => index).obs;
        mySnake = List.generate(3, (index) => index).obs;
        snakeRoot = Directions.RIGHT.obs;
        prevRoot = Directions.RIGHT.obs;
        play = true.obs;
        userRate.value = 0;
      }
    });
  }

  Game() {
    switch (snakeRoot.value) {
      case Directions.RIGHT:
        RightRoot();
        break;
      case Directions.LEFT:
        LeftRoot();
        break;
      case Directions.UP:
        UpRoot();
        break;
      case Directions.BOTTOM:
        BottomRoot();
        break;
    }
  }

  UpRoot() {
    if (mySnake.last == food) {
      userRate.value = userRate.value + 1;
      if (mySnake.last < Row)
        mySnake.add((((mySnake.last * col) - (Row - mySnake.last)) +
            ((Row - mySnake.last) * col)));
      else
        mySnake.add(mySnake.last - Row);
      food_position();
    } else {
      if (mySnake.last < Row)
        mySnake.add((((mySnake.last * col) - (Row - mySnake.last)) +
            ((Row - mySnake.last) * col)));
      else
        mySnake.add(mySnake.last - Row);
      mySnake.removeAt(0);
    }
  }

  RightRoot() {
    if (mySnake.last == food) {
      userRate.value = userRate.value + 1;
      if (mySnake.last != 0 && (mySnake.last + 1) % (Row) == 0)
        mySnake.add((mySnake.last + 1) - Row);
      else
        mySnake.add(mySnake.last + 1);
      food_position();
    } else {
      if (mySnake.last != 0 && (mySnake.last + 1) % Row == 0) {
        mySnake.add((mySnake.last + 1) - Row);
      } else
        mySnake.add(mySnake.last + 1);
      mySnake.removeAt(0);
    }
  }

  LeftRoot() {
    if (mySnake.last == food) {
      userRate.value = userRate.value + 1;
      if (mySnake.last % Row == 0)
        mySnake.add(mySnake.last + (Row - 1));
      else
        mySnake.add(mySnake.last - 1);
      food_position();
    } else {
      if (mySnake.last % Row == 0) {
        mySnake.add(mySnake.last + (Row - 1));
      } else
        mySnake.add(mySnake.last - 1);
      mySnake.removeAt(0);
    }
  }

  BottomRoot() {
    if (mySnake.last == food) {
      userRate.value = userRate.value + 1;
      if (mySnake.last >= 90)
        mySnake.add(mySnake.last - (Row * (col - 1)));
      else
        mySnake.add(mySnake.last + Row);
      food_position();
    } else {
      if (mySnake.last >= 90)
        mySnake.add(mySnake.last - (Row * (col - 1)));
      else
        mySnake.add(mySnake.last + Row);
      mySnake.removeAt(0);
    }
  }

  food_position() {
    do {
      food = Random().nextInt(100);
    } while (mySnake.contains(food));
  }

  loseGame(int num) {
    for (var i = 0; i < mySnake.length - 1; i++) {
      if (mySnake.elementAt(i) == mySnake.last) {
        return true;
      }
    }
    return false;
  }
}
