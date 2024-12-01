import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
class QuestsScreen extends StatelessWidget {
  QuestsScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.all(8.0),
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
  void didChangeDependencies() async {
    super.didChangeDependencies();

    var storage = await sharedPref;
    answers =  storage.getStringList("answers")??List.filled(questsList.length, "");
    //если викторина пройдена до конца
    if(answers.where((element) => element != "").length != questsList.length){
      setState(() {});
    }
    else{
      storage.remove("answers");
      answers =List.filled(questsList.length, "");
    }
    print("didChangeDep");
    print(answers);
    print(storage.getStringList("answers"));



  }


  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    Future.microtask(() async {
      var storage = await sharedPref;
      await storage.setStringList("answers", answers);
      await storage.setInt("index", _questIndex);

      print("dispose");
    });

    super.dispose();

  }
  //UI переменные/функции
  static final Sgreen = MaterialStateProperty.all(Colors.green);
  static final Sgrey = MaterialStateProperty.all(Colors.grey);
  Color btnColor(String ans, String corrAns) =>
      (ans == corrAns) ? Colors.green : Colors.red;



  //Хранилища данных
  List<String> answers = List.filled(questsList.length, "") ;

  static const List<Question> questsList = [
    Question("Какова глубина байкала, (м)", "1642", "1500", "1432", "1239", "1642"),
    Question("Какова высота эвереста, (м)", "9000", "6780", "8100", "8849", "8849"),
    Question("Самое большое животное в мире", "Жираф", "Синий кит", "Китовая акула", "Косатка", "Синий кит"),
    Question("Какая планета самая горячая", "Меркурий", "Марс", "Юпитер", "Плутон", "Марс"),
    Question("Какой океан самый большой на Земле?", "Индийский", "Тихий", "Атлантический", "Южный", "Тихий"),
  ]; //вопросы

  Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();


  //внести ответ
  void setAns(String value){
    if(answers[_questIndex] == ""){
      answers[_questIndex] = value;

      if(value == questsList[_questIndex].correctAns){
        correctAns++;
      }

      setState(() {});
    }

  }


  //Перебор вопросов
  void prevQuest(){
    if(_questIndex!=0){
      setState(() {
        _questIndex--;
        //answer = null;
      });
    }
  }
  void nextQuest(){
    if(_questIndex != questsList.length-1){
      _questIndex++;
      setState(() {
        //answer = null;
      });
    }
  }
  int _questIndex = 0;

  //количество правильных ответов
  int correctAns = 0;
  @override
  Widget build(BuildContext context) {
    print("build");

    print(answers);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Вопрос
        SizedBox(
            child: Center(child: Text(questsList[_questIndex].quest))),

        //Список ответов
        ButtonWidget(text: questsList[_questIndex].ans1, onPressed:()=> setAns(questsList[_questIndex].ans1), color: answers[_questIndex] != questsList[_questIndex].ans1 ? Colors.grey : btnColor(questsList[_questIndex].ans1, questsList[_questIndex].correctAns),),
        ButtonWidget(text: questsList[_questIndex].ans2, onPressed:()=> setAns(questsList[_questIndex].ans2), color: answers[_questIndex] != questsList[_questIndex].ans2  ? Colors.grey : btnColor(questsList[_questIndex].ans2, questsList[_questIndex].correctAns)),
        ButtonWidget(text: questsList[_questIndex].ans3, onPressed:()=> setAns(questsList[_questIndex].ans3), color: answers[_questIndex] != questsList[_questIndex].ans3  ? Colors.grey : btnColor(questsList[_questIndex].ans3, questsList[_questIndex].correctAns)),
        ButtonWidget(text: questsList[_questIndex].ans4, onPressed:()=> setAns(questsList[_questIndex].ans4), color: answers[_questIndex] != questsList[_questIndex].ans4  ? Colors.grey : btnColor(questsList[_questIndex].ans4, questsList[_questIndex].correctAns)),

        const SizedBox(
          height: 35,
        ),

        //Кнопки next / prev
        Row(
          children: [
            Expanded(
                child: TextButton(onPressed: prevQuest,  child: Text("Предыдущий", style: TextStyle(color: Colors.white),), style: ButtonStyle(backgroundColor: _questIndex==0 ? Sgrey : Sgreen),)),

            const SizedBox(
              width: 40,
            ),
            Expanded(
                child: TextButton(onPressed: nextQuest,  child: Text("Следующий", style: TextStyle(color: Colors.white),), style: ButtonStyle(backgroundColor: _questIndex == questsList.length-1 ? Sgrey : Sgreen),)),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        (answers.where((element) => element != null).length == questsList.length) ?
        Text("Правильных ответов $correctAns") : const SizedBox(),
        const SizedBox(
          height: 65,
        ),


      ],
    );
  }
}


/*
class DataProvider extends InheritedWidget{

  final int correctAnswer;//номер индекса в списке вопросов
  final List<String?> answers;//номер индекса в списке вопросов
  final List<Question> quests;

  const DataProvider({super.key, required this.quests, required this.answers, required Widget child, required this.correctAnswer, }):super(child: child);

  @override
  bool updateShouldNotify(covariant DataProvider oldWidget) {
    // TODO: implement updateShouldNotify
    return answers.length == quests.length; //количество ненулл объектов в списке ответов (answers) == количество объектов в списке вопросов
  }

}

 */







class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key,required this.text,required this.onPressed, required this.color});
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
        child: Text(text, style: TextStyle(color: Colors.white),), ),
    );
  }}



class Question {
  final String quest;
  final String ans1;
  final String ans2;
  final String ans3;
  final String ans4;
  final String correctAns;

  const Question(this.quest, this.ans1, this.ans2, this.ans3, this.ans4, this.correctAns,);
}



 */
