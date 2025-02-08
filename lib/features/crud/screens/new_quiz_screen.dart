import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quests/constants.dart';
import 'package:quests/features/crud/screens/quests_storage_screen.dart';
import 'package:quests/features/game/screens/quiz_game_screen.dart';

class NewQuestScreen extends StatefulWidget {
  const NewQuestScreen({super.key});

  @override
  State<NewQuestScreen> createState() => _NewQuestScreenState();
}

class _NewQuestScreenState extends State<NewQuestScreen> {
  //Контроллеры
  TextEditingController quizNameController = TextEditingController();
  TextEditingController answerTextController = TextEditingController();
  TextEditingController questionTextController = TextEditingController();

  //Локальные переменные пользовательских данных
  List<Question> userQuestionsList = [];
  List<String> userAnswersList = [];
  String? userCorrectAns;

  //Строки исключений для валидации полей
  String answerFieldWarningText = "";
  String questionFieldWarningText = "";
  String quizFieldWarningText = "";

  //Добавление викторины в хранилища.
  void addQuizzesToStorage(String textFieldString, Quiz quiz) {
    addQuizToList(textFieldString, quiz);
    addQuizToHive(textFieldString, quiz);
  }

  void addQuizToList(String textFieldString, Quiz quiz) {
    Storage.quizzesStorage.add(quiz);
  }

  Future<void> addQuizToHive(String textFieldString, Quiz quiz) async {
    var box = await Hive.openBox<Quiz>(QUIZ_BOX_NAME);
    await box.add(quiz);
    await box.close();
  }

  //Create & add question
  void questAddManager() {
    if (userAnswersList.length == MAX_QUESTIONS_COUNT &&
        questionTextController.text.isNotEmpty) {
      addUserQuestionsToList();
      resetUserData();
    } else {
      questionFieldWarningText = "Настройка вопроса не окончена";
      answerFieldWarningText = "Настройка вопроса не окончена";
    }
  }

  void addQuizManager(BuildContext context) {
    if (quizNameController.text.toString().isNotEmpty &&
        userQuestionsList.isNotEmpty) {
      Quiz quiz = Quiz(
          name: quizNameController.text.toString(),
          questions: userQuestionsList,
          id: Storage.quizzesStorage.length,
          userCorrectAnswersCount: 0,
          userLastQuestionIndex: 0,
          userAnswersList: []);
      addQuizzesToStorage(quizNameController.text.toString(), quiz);
      Navigator.pushNamedAndRemoveUntil(
          context, "/myQuests", ModalRoute.withName("/"));
    } else {
      //Navigator.pop(context, "/myQuests");
      quizFieldWarningText = "Заполните поле или добавьте хотя бы один вопрос";
      setState(() {});
    }
  }

  void addUserQuestionsToList() {
    userQuestionsList.add(Question(
        quest: questionTextController.text,
        ans1: userAnswersList[0],
        ans2: userAnswersList[1],
        ans3: userAnswersList[2],
        ans4: userAnswersList[3],
        correctAns: userCorrectAns!));
  }

  void resetUserData() {
    userAnswersList = [];
    userCorrectAns = null;

    questionTextController.clear();
    answerTextController.clear();

    questionFieldWarningText = "";
    answerFieldWarningText = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        height: 70,
        child: Row(
          children: [
            AnswerTypeSelectionButton(
              text: "Удалить вопрос",
              color: Colors.black,
              onPressed: () {},
            ),
            AnswerTypeSelectionButton(
              text: "Добавить вопрос",
              color: Colors.black,
              onPressed: () {
                questAddManager();
                setState(() {});
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              addQuizManager(context);
            },
            child: const Text(
              "Сохранить",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: quizNameController,
                      decoration: const InputDecoration(
                        labelText: "Название викторины",
                      ),
                    ),

                    Text(
                      quizFieldWarningText,
                      style: TextStyle(color: Colors.red),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    //Формирование вопросов

                    //------Поле вопроса-----------

                    TextField(
                      controller: questionTextController,
                      decoration: const InputDecoration(
                          labelText: "Формулировка вопроса",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0))),
                    ),
                    Text(
                      questionFieldWarningText,
                      style: const TextStyle(color: Colors.red),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    //------Поле варианта ответа----------

                    TextFormField(
                      controller: answerTextController,
                      decoration: const InputDecoration(
                          labelText: "Вариант ответа",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0))),
                    ),
                    Text(
                      answerFieldWarningText,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        AnswerTypeSelectionButton(
                          text: "Неправильный",
                          color: Colors.red,
                          onPressed: () {
                            incorrectAnswerValidation();
                            setState(() {});
                          },
                        ),
                        AnswerTypeSelectionButton(
                          text: "Правильный",
                          color: Colors.green,
                          onPressed: () {
                            correctAnswerValidation();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: userAnswersList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        UserAnswerWidget(
                      text: userAnswersList[index],
                      correctAns: userCorrectAns ?? "",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void correctAnswerValidation() {
    if (userAnswersList.contains(answerTextController.text.toString())) {
      answerFieldWarningText = "Такой вариант ответа уже существует";
    } else if (answerTextController.text.toString().isEmpty) {
      answerFieldWarningText = "Заполните поле";
    } else if (userCorrectAns != null) {
      answerFieldWarningText = "Лимит вопросов данного типа исчерпан";
    } else if (userAnswersList.length != 4 &&
        answerTextController.text.toString().isNotEmpty &&
        userCorrectAns == null) {
      userAnswersList.add(answerTextController.text);
      userCorrectAns = answerTextController.text.toString();
      answerTextController.clear();
      answerFieldWarningText = "";
    }
  }

  void incorrectAnswerValidation() {
    if (answerTextController.text.toString().isEmpty) {
      answerFieldWarningText = "Заполните поле";
    } else if ((userAnswersList.length == 3 && userCorrectAns == null) ||
        userAnswersList.length == 4) {
      answerFieldWarningText = "Лимит данного типа вопросов исчерпан";
    } else if (userAnswersList.contains(answerTextController.text.toString())) {
      answerFieldWarningText = "Такой вариант ответа уже существует";
    } else if (userAnswersList.length != 4 &&
        answerTextController.text.toString().isNotEmpty) {
      userAnswersList.add(answerTextController.text);
      answerTextController.clear();
      answerFieldWarningText = "";
    }
  }
}

class AnswerTypeSelectionButton extends StatelessWidget {
  Color color;
  String text;
  Function()? onPressed;
  AnswerTypeSelectionButton(
      {super.key,
      required this.color,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}

class UserAnswerWidget extends StatelessWidget {
  const UserAnswerWidget({
    super.key,
    required this.text,
    required this.correctAns,
  });
  final String correctAns;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 2),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: text == correctAns ? Colors.green : Colors.red,
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
