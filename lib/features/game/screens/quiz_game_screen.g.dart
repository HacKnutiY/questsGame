// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_game_screen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 0;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      quest: fields[0] as String,
      ans1: fields[1] as String,
      ans2: fields[2] as String,
      ans3: fields[3] as String,
      ans4: fields[4] as String,
      correctAns: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.quest)
      ..writeByte(1)
      ..write(obj.ans1)
      ..writeByte(2)
      ..write(obj.ans2)
      ..writeByte(3)
      ..write(obj.ans3)
      ..writeByte(4)
      ..write(obj.ans4)
      ..writeByte(5)
      ..write(obj.correctAns);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
