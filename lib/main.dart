import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quests/constants.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:quests/features/crud/screens/quests_storage_screen.dart'
    show QuestionAdapter, Quiz, QuizAdapter;
import 'package:quests/features/game/screens/quiz_game_screen.dart';

import 'app.dart';

void main() async {
  //Инициализация + регистрация адаптера кастомного класса
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(QuestionAdapter());
  }

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(QuizAdapter());
  }

  runApp(const QuizApp());
}
