import 'package:flutter/material.dart';
import 'package:quests/features/crud/screens/quests_storage.dart';


class NewQuestScreen extends StatefulWidget {
   NewQuestScreen({super.key});

  @override
  State<NewQuestScreen> createState() => _NewQuestScreenState();
}

class _NewQuestScreenState extends State<NewQuestScreen> {

  @override
  Future<void> deactivate() async {
    // TODO: implement didChangeDependencies
    var sPref = await sharedPreferences;

    sPref.setStringList("questsStorage", Storage.questsStorage);
    print("Данные сохранены!");


    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
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
                      }

                    Navigator.popAndPushNamed(context, "/myQuests");
                    print(Storage.questsStorage);
                  }, child: Text("Сохранить", style: TextStyle(fontSize: 25),))
              ],
            )
        )
    );
  }
}
