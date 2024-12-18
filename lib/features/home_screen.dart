import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quests/constants.dart';
import 'package:quests/features/crud/screens/quests_storage_screen.dart';
import 'package:quests/features/game/screens/quest_game_screen.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isQuestsLoad = false;



  @override
  void initState() {
    // TODO: if state переместитьиз метода сюда

    loadQuests();
    super.initState();
  }


  Future<void> loadQuests() async{
    final box = await Hive.openBox<Quiz>(QUIZ_BOX_NAME);
    //Hive.deleteFromDisk();

    if(!isQuestsLoad){
      Storage.quizesStorage = box.values.toList();
      isQuestsLoad = true;

    }
    box.close();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Викторина"),
          SizedBox(height: 40,),
          TextButton(onPressed: (){

            Navigator.pushNamed(context, "/myQuests");
          }, child: Text("Мои викторины")),
          TextButton(onPressed: dataWork, child: Text("Вопросы по сети")),
          ],))),
    );
  }
}
Future<void> dataWork() async {
/*
  var box = await Hive.openBox<Question>(TEST_BOX_NAME);
  await box.add(Question("quest", "ans1", "ans2", "ans3", "ans4", "correctAns"));

  box.close();*/
}

