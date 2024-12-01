

import 'package:flutter/material.dart';
import 'package:quests/features/crud/screens/quests_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var sp = SharedPreferences.getInstance();



  Future<void> setQuests() async{
    final storage = await sp;
    if(storage.getString("questsKey") == null){
      storage.setString("questsKey",
          '''
        [
          {
            quest: "Какова глубина байкала, (м)",
            ans1: "1642",
            ans2: "1500",
            ans3: "1432",
            ans4: "1239",
            correctAns: "1642"
          },
          {
            quest: "Какова глубина байкала, (м)",
            ans1: "1642",
            ans2: "1500",
            ans3: "1432",
            ans4: "1239",
            correctAns: "1642"
          },
          {
            quest: "Какова глубина байкала, (м)",
            ans1: "1642",
            ans2: "1500",
            ans3: "1432",
            ans4: "1239",
            correctAns: "1642"
          },
        ]
        ''');
    }

  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    var storage = await sp;
    Storage.questsStorage = storage.getStringList("questsStorage") ?? [];
    print("Данные заменены!");
    super.didChangeDependencies();
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
            setQuests();
            Navigator.pushNamed(context, "/myQuests");
          }, child: Text("Мои викторины")),
          TextButton(onPressed: (){}, child: Text("Вопросы по сети")),
          ],))),
    );
  }
}
