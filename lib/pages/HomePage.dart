import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneekgame/module/GameLogic.dart';
import 'package:sneekgame/pages/GameScreen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GameRate = Get.put(MyGame());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(()=> Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Your Rate is ${GameRate.userRate}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              Text(
                GameRate.userRate.toString(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: GameScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
