
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quests/constants.dart';
import 'package:quests/features/game/screens/quest_game_screen.dart' show Question;


class Storage {
  static List<Quiz> quizesStorage = [];
  static List<Question> testStorage = [];


}
class QuestionAdapter extends TypeAdapter<Question>{
  @override
  int get typeId => 0;

  @override
  Question read(BinaryReader reader) {
    //TODO описать как считывать/записывать поля Question и Quiz класса
    final quest = reader.readString();
    final ans1 = reader.readString();
    final ans2 = reader.readString();
    final ans3 = reader.readString();
    final ans4 = reader.readString();
    final correctAns = reader.readString();

    return Question(quest, ans1, ans2, ans3, ans4, correctAns);
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer.writeString(obj.quest);
    writer.writeString(obj.ans1);
    writer.writeString(obj.ans2);
    writer.writeString(obj.ans3);
    writer.writeString(obj.ans4);
    writer.writeString(obj.correctAns);
  }

}



class QuizAdapter extends TypeAdapter<Quiz>{
  @override
  int get typeId => 1;


  @override
  Quiz read(BinaryReader reader) {
    final name = reader.readString();
    final questions = reader.readList().cast<Question>();

    return Quiz(name: name, questions: questions);
  }


  @override
  void write(BinaryWriter writer, Quiz obj) {
    writer.writeString(obj.name);
    writer.writeList(obj.questions);

  }

}


class Quiz{
  String name;
  List<Question> questions = [];
  Quiz({required this.name, required this.questions});
}
// Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
class QuestsStorageScreen extends StatefulWidget {

  const QuestsStorageScreen({super.key});

  @override
  State<QuestsStorageScreen> createState() => _QuestsStorageScreenState();
}

class _QuestsStorageScreenState extends State<QuestsStorageScreen> {

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, "/myQuests/newQuest",);
      },
      child: Text("+", style: TextStyle(fontSize: 30),),),
      body: SafeArea(

          child: Stack(
            children:[
              ListView.builder(
                  itemCount: Storage.quizesStorage.length,
                  itemBuilder: (BuildContext context, int index)=> QuestWidget(text: Storage.quizesStorage[index].name)),
  Positioned(
  bottom: 0,
  left: 0,
  child: TextButton(onPressed: (){Storage.quizesStorage.clear(); setState(() {

  });}, child: Text("Remove all")),
)
            ] ),
          )
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




/*List<Widget> getWidgets(){
  List<Widget> questWidgetsList=[];
  for (String element in Storage.questsStorage) {
    String name = jsonDecode(element)["name"];
    questWidgetsList.add(QuestWidget(text: name));
  }


  return questWidgetsList;
}*/

