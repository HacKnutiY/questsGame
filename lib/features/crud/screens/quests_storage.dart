import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static List<String> questsStorage = [];


}
Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
class QuestsStorageScreen extends StatefulWidget {

  QuestsStorageScreen({super.key});

  @override
  State<QuestsStorageScreen> createState() => _QuestsStorageScreenState();
}

class _QuestsStorageScreenState extends State<QuestsStorageScreen> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamedAndRemoveUntil(context, "/myQuests/newQuest",ModalRoute.withName('/') );
        /*
        questsStorage.add('''{"name": "quiz$i"}''');
        i++;
        setState(() {});
         */
      },
      child: Text("+", style: TextStyle(fontSize: 30),),),
      body: SafeArea(
          child: ListView(

            children: getWidgets(),
          )
      ),
    );
  }
}


class QuestWidget extends StatelessWidget {
  const QuestWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.pushNamed(context, "/myQuests/Quiz");},
      child: Padding(
        padding: EdgeInsetsDirectional.all(10),
        child: Container(
          padding: EdgeInsetsDirectional.all(10),
          color: Colors.black,
          child: Center(child: Text(text, style: TextStyle(fontSize: 25, color: Colors.white),),),
        ),
      ),
    );
  }
}


List<Widget> getWidgets(){
  List<Widget> questWidgetsList=[];
  for (String element in Storage.questsStorage) {
    String name = jsonDecode(element)["name"];
    questWidgetsList.add(QuestWidget(text: name));
  }


  return questWidgetsList;
}
