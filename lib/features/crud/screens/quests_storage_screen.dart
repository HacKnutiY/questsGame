import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quests/constants.dart';
import 'package:quests/features/game/screens/quiz_game_screen.dart'
    show Question;

part 'quests_storage_screen.g.dart';

class Storage {
  static List<Quiz> quizzesStorage = [];
}

@HiveType(typeId: 1)
class Quiz extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int id;
  @HiveField(2)
  List<Question> questions;
  //User data
  @HiveField(3)
  int userLastQuestionIndex;
  @HiveField(4)
  List<String> userAnswersList = [];
  @HiveField(5)
  int userCorrectAnswersCount;
  Quiz({
    required this.id,
    required this.name,
    required this.questions,
    required this.userAnswersList,
    required this.userCorrectAnswersCount,
    required this.userLastQuestionIndex,
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

  List<Quiz> sortedQuizzes = Storage.quizzesStorage;

  void removeQuizFromHive() async {
    var box = await Hive.openBox<Quiz>(QUIZ_BOX_NAME);
    box.clear();
  }

  void removeQuizFromList() {
    Storage.quizzesStorage.clear();
    sortedQuizzes.clear();
  }

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
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: ListView.builder(
                itemCount: sortedQuizzes.length,
                itemBuilder: (BuildContext context, int index) => QuizWidget(
                  text: sortedQuizzes[index].name,
                  index: sortedQuizzes[index].id,
                ),
              ),
            ),
          ),
          //Поисковая строка
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 22),
            child: TextField(
              onChanged: (value) {
                sortedQuizzes = Storage.quizzesStorage
                    .where((Quiz element) => element.name.contains(value))
                    .toList();
                setState(() {});
              },
              controller: searchFieldController,
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Найти викторину",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0))),
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
      ),
    );
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


/*List<Widget> getWidgets(){
  List<Widget> questWidgetsList=[];
  for (String element in Storage.questsStorage) {
    String name = jsonDecode(element)["name"];
    questWidgetsList.add(QuestWidget(text: name));
  }


  return questWidgetsList;
}*/

