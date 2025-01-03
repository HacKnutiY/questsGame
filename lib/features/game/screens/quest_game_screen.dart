import 'package:flutter/material.dart';
import 'package:quests/features/crud/screens/quests_storage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({
    super.key,
  });

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionsWidget(),
          ],
        ),
      ),
    );
  }
}

class QuestionsWidget extends StatefulWidget {
  const QuestionsWidget({super.key});

  @override
  State<QuestionsWidget> createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  @override
  void initState() {
    //loadData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final quiz = ModalRoute.of(context)!.settings.arguments as Quiz;
    questions = quiz.questions;
  }

  //UI переменные/функции
  static final Sgreen = MaterialStateProperty.all(Colors.green);
  static final Sgrey = MaterialStateProperty.all(Colors.grey);
  Color btnColor(String ans, String corrAns) =>
      (ans == corrAns) ? Colors.green : Colors.red;

  //Хранилища данных
  late List<String> answers = List.filled(questions.length, "");
  late List<Question> questions;

  //Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();

  //внести ответ
  void setAns(String value) {
    if (answers[_questIndex].isEmpty) {
      answers[_questIndex] = value;

      if (value == questions[_questIndex].correctAns) {
        correctAns++;
      }

      setState(() {});
    }
  }

  //Перебор вопросов
  void prevQuest() {
    if (_questIndex != 0) {
      setState(() {
        _questIndex--;
      });
    }
  }

  void nextQuest() {
    if (_questIndex != questions.length - 1) {
      _questIndex++;
      setState(() {});
    }
  }

  int _questIndex = 0;

  //количество правильных ответов
  int correctAns = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Вопрос
        SizedBox(child: Center(child: Text(questions[_questIndex].quest))),

        //Список ответов
        ButtonWidget(
          text: questions[_questIndex].ans1,
          onPressed: () => setAns(questions[_questIndex].ans1),
          color: answers[_questIndex] != questions[_questIndex].ans1
              ? Colors.grey
              : btnColor(questions[_questIndex].ans1,
                  questions[_questIndex].correctAns),
        ),
        ButtonWidget(
            text: questions[_questIndex].ans2,
            onPressed: () => setAns(questions[_questIndex].ans2),
            color: answers[_questIndex] != questions[_questIndex].ans2
                ? Colors.grey
                : btnColor(questions[_questIndex].ans2,
                    questions[_questIndex].correctAns)),
        ButtonWidget(
            text: questions[_questIndex].ans3,
            onPressed: () => setAns(questions[_questIndex].ans3),
            color: answers[_questIndex] != questions[_questIndex].ans3
                ? Colors.grey
                : btnColor(questions[_questIndex].ans3,
                    questions[_questIndex].correctAns)),
        ButtonWidget(
            text: questions[_questIndex].ans4,
            onPressed: () => setAns(questions[_questIndex].ans4),
            color: answers[_questIndex] != questions[_questIndex].ans4
                ? Colors.grey
                : btnColor(questions[_questIndex].ans4,
                    questions[_questIndex].correctAns)),

        const SizedBox(
          height: 35,
        ),

        //Кнопки next / prev
        Row(
          children: [
            Expanded(
                child: TextButton(
              onPressed: prevQuest,
              child: Text(
                "Предыдущий",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: _questIndex == 0 ? Sgrey : Sgreen),
            )),
            const SizedBox(
              width: 40,
            ),
            Expanded(
                child: TextButton(
              onPressed: nextQuest,
              child: Text(
                "Следующий",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      _questIndex == questions.length - 1 ? Sgrey : Sgreen),
            )),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Text("Правильных ответов $correctAns"),
        const SizedBox(
          height: 65,
        ),
      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});
  final String text;

  final Color color;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class Question {
  @override
  String toString() => "$quest, $ans1, $ans2, $ans3, $ans4, $correctAns";

  final String quest;
  final String ans1;
  final String ans2;
  final String ans3;
  final String ans4;
  final String correctAns;

  const Question({
    required this.quest,
    required this.ans1,
    required this.ans2,
    required this.ans3,
    required this.ans4,
    required this.correctAns,
  });
}
