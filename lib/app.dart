import 'package:hive/hive.dart';
import 'package:quests/features/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:quests/features/home_screen.dart';
import 'package:quests/features/crud/screens/new_quest_screen.dart';
// import 'package:lessons/quiz_proj/features/screens/quest_game_screen.dart';
import 'package:quests/features/game/screens/quest_game_screen.dart';
import 'package:quests/features/crud/screens/quests_storage_screen.dart';
// import 'package:lessons/storages/shared_prefs/sp_widget.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //ApiClient().getPosts();
    return  MaterialApp(

      debugShowCheckedModeBanner: false,

      routes: {
        "/" : (context) => HomeScreen(),
        "/myQuests" : (context) => QuestsStorageScreen(),
        "/myQuests/newQuest" : (context) => NewQuestScreen(),
        "/myQuests/Quiz" : (context) => QuestsScreen(),
      },

      initialRoute: "/",

    );
  }
}
