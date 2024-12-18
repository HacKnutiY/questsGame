import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quests/constants.dart';
import 'package:quests/features/crud/screens/quests_storage_screen.dart';
import 'package:quests/features/game/screens/quest_game_screen.dart';


class NewQuestScreen extends StatefulWidget {
   NewQuestScreen({super.key});

  @override
  State<NewQuestScreen> createState() => _NewQuestScreenState();
}


class _NewQuestScreenState extends State<NewQuestScreen> {
  TextEditingController controller = TextEditingController();
  int currentQuestsCount = Storage.quizesStorage.length;
  Quiz? quiz;
  

  @override
  Future<void> deactivate() async {
    // TODO: implement didChangeDependencies
    var box = await Hive.openBox<Quiz>(QUIZ_BOX_NAME);

    if(currentQuestsCount != Storage.quizesStorage.length && quiz!=null){
      await box.add(quiz!);

    }

    box.close();


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
                        quiz = Quiz(name: textFieldString.toString(), questions: [Question("Какова глубина байкала, (м)", "1642", "1500", "1432", "1239", "1642"),]);
                        Storage.quizesStorage.add(quiz!);
                        Navigator.pushNamedAndRemoveUntil(context, "/myQuests", ModalRoute.withName("/"));
                      }else{
                        Navigator.pop(context, "/myQuests");

                      }

                    //
                  }, child: Text("Сохранить", style: TextStyle(fontSize: 25),))
              ],
            )
        )
    );
  }
}
