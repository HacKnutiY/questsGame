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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  print("didChangeDependencies");
  super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
  print("build Storage");
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, "/myQuests/newQuest",);
      },
      child: Text("+", style: TextStyle(fontSize: 30),),),
      body: SafeArea(

          child: Stack(
            children:[
              ListView.builder(
                  itemCount: Storage.questsStorage.length,
                  itemBuilder: (BuildContext context, int index) => QuestWidget(text: (Storage.questsStorage[index]))),
  Positioned(
  bottom: 0,
  left: 0,
  child: TextButton(onPressed: (){Storage.questsStorage.clear(); setState(() {

  });}, child: Text("Remove all")),
)
            ] ),
          )
      );

  }
}


class QuestWidget extends StatelessWidget {
  String decodeName(String jsonString){
    String text = jsonDecode(jsonString)["name"];
    return text;
  }
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
          child: Center(child: Text(decodeName(text), style: TextStyle(fontSize: 25, color: Colors.white),),),
        ),
      ),
    );
  }
}




/*List<Widget> getWidgets(){
  List<Widget> questWidgetsList=[];
  for (String element in Storage.questsStorage) {
    String name = jsonDecode(element)["name"];
    questWidgetsList.add(QuestWidget(text: name));
  }


  return questWidgetsList;
}*/

