import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quests/constants.dart';
import 'package:quests/features/crud/screens/quests_storage_screen.dart';
import 'package:quests/features/game/screens/quiz_game_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isQuizessLoad = false;

  @override
  void initState() {
    // TODO: if state переместитьиз метода сюда

    loadQuizzes();
    super.initState();
  }

  Future<void> loadQuizzes() async {
    var box = await Hive.openBox<Quiz>(QUIZ_BOX_NAME);
    if (!isQuizessLoad) {
      Storage.quizzesStorage = box.values.toList();
      isQuizessLoad = true;

      print("Box открыт");
    }

    await box.close();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Викторина"),
          SizedBox(
            height: 40,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/myQuests");
            },
            child: Text("Мои викторины"),
          ),
          TextButton(
            onPressed: dataWork,
            child: Text("Вопросы по сети"),
          ),
        ],
      ))),
    );
  }
}

Future<void> dataWork() async {}
