import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quests/constants.dart';
import 'package:quests/features/crud/screens/quests_storage_screen.dart'
    show QuestionAdapter, QuizAdapter;

import 'app.dart';

void main() async {
  //Инициализация + регистрация адаптера кастомного класса
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0) && !Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(QuestionAdapter());
    Hive.registerAdapter(QuizAdapter());
  }

  runApp(const QuizApp());
}
