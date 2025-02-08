// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quests_storage_screen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizAdapter extends TypeAdapter<Quiz> {
  @override
  final int typeId = 1;

  @override
  Quiz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quiz(
      id: fields[1] as int,
      name: fields[0] as String,
      questions: (fields[2] as List).cast<Question>(),
      userAnswersList: (fields[4] as List).cast<String>(),
      userCorrectAnswersCount: fields[5] as int,
      userLastQuestionIndex: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Quiz obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.questions)
      ..writeByte(3)
      ..write(obj.userLastQuestionIndex)
      ..writeByte(4)
      ..write(obj.userAnswersList)
      ..writeByte(5)
      ..write(obj.userCorrectAnswersCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
