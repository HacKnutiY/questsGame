import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quests/constants.dart';
import 'package:quests/features/game/screens/quest_game_screen.dart'
    show Question;

class Storage {
  static List<Quiz> quizzesStorage = [];
}

class QuestionAdapter extends TypeAdapter<Question> {
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

    return Question(
        quest: quest,
        ans1: ans1,
        ans2: ans2,
        ans3: ans3,
        ans4: ans4,
        correctAns: correctAns);
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

class QuizAdapter extends TypeAdapter<Quiz> {
  @override
  int get typeId => 1;

  @override
  Quiz read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final questions = reader.readList().cast<Question>();

    return Quiz(name: name, questions: questions, id: id);
  }

  @override
  void write(BinaryWriter writer, Quiz obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeList(obj.questions);
  }
}

class Quiz {
  String name;
  int id;
  List<Question> questions = [];
  Quiz({
    required this.id,
    required this.name,
    required this.questions,
  });
}

class QuestsStorageScreen extends StatefulWidget {
  const QuestsStorageScreen({super.key});

  @override
  State<QuestsStorageScreen> createState() => _QuestsStorageScreenState();
}

class _QuestsStorageScreenState extends State<QuestsStorageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    searchFieldController = TextEditingController();
    super.initState();
  }

  late TextEditingController searchFieldController;

  List sortedQuizzes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/myQuests/newQuest",
            );
          },
          child: const Text(
            "+",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Stack(
          children: [
            //Список викторин
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: ListView.builder(
                    itemCount: Storage.quizzesStorage.length,
                    itemBuilder: (BuildContext context, int index) =>
                        QuizWidget(
                            text: Storage.quizzesStorage[index].name,
                            index: Storage.quizzesStorage[index].id)),
              ),
            ),
            //Поисковая строка
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 22),
              child: TextField(
                onChanged: (value) => {},
                controller: searchFieldController,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Найти викторину",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.0))),
              ),
            ),
            //Remove all кнопка
            Positioned(
              bottom: 0,
              left: 0,
              child: TextButton(
                  onPressed: () {
                    removeQuizFromStorage();
                    setState(() {});
                  },
                  child: Text("Remove all")),
            )
          ],
        ),);
  }

  void removeQuizFromStorage() {
    removeQuizFromList();
    removeQuizFromHive();
  }
}

class QuizWidget extends StatelessWidget {
  const QuizWidget({super.key, required this.text, required this.index});
  final String text;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/myQuests/Quiz",
            arguments: Storage.quizzesStorage[index]);
      },
      child: Padding(
        padding: EdgeInsetsDirectional.all(10),
        child: Container(
          padding: EdgeInsetsDirectional.all(10),
          color: Colors.black,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

void removeQuizFromHive() async {
  var box = await Hive.openBox<Quiz>(QUIZ_BOX_NAME);
  box.clear();
}

void removeQuizFromList() {
  Storage.quizzesStorage.clear();
}
/*List<Widget> getWidgets(){
  List<Widget> questWidgetsList=[];
  for (String element in Storage.questsStorage) {
    String name = jsonDecode(element)["name"];
    questWidgetsList.add(QuestWidget(text: name));
  }


  return questWidgetsList;
}*/

