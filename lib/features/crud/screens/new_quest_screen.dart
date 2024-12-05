import 'package:flutter/material.dart';
import 'package:quests/features/crud/screens/quests_storage_screen.dart';


class NewQuestScreen extends StatefulWidget {
   NewQuestScreen({super.key});

  @override
  State<NewQuestScreen> createState() => _NewQuestScreenState();
}
class _NewQuestScreenState extends State<NewQuestScreen> {
  TextEditingController controller = TextEditingController();

  int questsCount = Storage.questsStorage.length;

  @override
  Future<void> deactivate() async {
    // TODO: implement didChangeDependencies
    if(questsCount!=Storage.questsStorage.length){
      var sPref = await sharedPreferences;

      sPref.setStringList("questsStorage", Storage.questsStorage);

    }


    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: TextField(controller: controller,),
                ),

                ElevatedButton(
                    onPressed: (){
                      String textFieldString = controller.text.toString();
                      if(textFieldString.isNotEmpty){
                        Storage.questsStorage.add('''{"name": "$textFieldString"}''');
                        Navigator.pushNamedAndRemoveUntil(context, "/myQuests", ModalRoute.withName("/"));
                      }else{
                        Navigator.pop(context, "/myQuests");

                      }

                    //
                    print(Storage.questsStorage);
                  }, child: Text("Сохранить", style: TextStyle(fontSize: 25),))
              ],
            )
        )
    );
  }
}
