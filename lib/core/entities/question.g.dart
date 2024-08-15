// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      imageUrl: json['imageUrl'] as String,
      correctAnswer: json['correctAnswer'] as String,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'correctAnswer': instance.correctAnswer,
    };
