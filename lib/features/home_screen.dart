
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quests/features/crud/screens/quests_storage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var sharedPreferences = SharedPreferences.getInstance();

  bool isQuestsLoad = false;



  @override
  void initState() {
    // TODO: implement initState
    loadQuests();
    super.initState();
  }


  Future<void> loadQuests() async{
    if(!isQuestsLoad){
      // var hiveStorage = Hive.box("HiveStorage");

      var preferences = await sharedPreferences;
      Storage.questsStorage = preferences.getStringList("questsStorage") ?? [];
      isQuestsLoad = true;
      print("Данные заменены!");
    }
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
          TextButton(onPressed: (){}, child: Text("Вопросы по сети")),
          ],))),
    );
  }
}
