import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestsScreen extends StatefulWidget {
   const QuestsScreen({super.key,});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {



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
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async{
    var storage = await sharedPref;
    answers =  storage.getStringList("answers")??List.filled(questsList.length, "");
    _questIndex =  storage.getInt("ansIndex")??0;
    correctAns =  storage.getInt("correctAns")??0;
    setState(() {});
  }

  @override
  Future<void> deactivate() async {

      var storage = await sharedPref;
      //если викторина не пройдена до конца и дан хотя бы один ответ(чтобы индекс вопроса не сохранялся если викторину даже не начали проходить)
      if(answers.where((element) => element != "").length != questsList.length){
        await storage.setStringList("answers", answers);
        await storage.setInt("ansIndex", _questIndex);
        await storage.setInt("correctAns", correctAns);
      }
      else{
        storage.remove("answers");
        storage.remove("ansIndex");

        //счетчик правильных ответов не работает корректно из за поставленного условия
        storage.remove("correctAns");
      }
      super.deactivate();

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
        (answers.where((element) => element != "").length == questsList.length) ?
        Text("Правильных ответов $correctAns") : const SizedBox(),
        const SizedBox(
          height: 65,
        ),
      ],
    );
  }
}








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
  @override
  String toString() => "$quest, $ans1, $ans2, $ans3, $ans4,$correctAns";

  final String quest;
  final String ans1;
  final String ans2;
  final String ans3;
  final String ans4;
  final String correctAns;

  const Question(this.quest, this.ans1, this.ans2, this.ans3, this.ans4, this.correctAns,);


}


