import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  const Question({
    required this.imageUrl,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  final String imageUrl;
  final String correctAnswer;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  List<Object?> get props => [
        imageUrl,
        correctAnswer,
      ];
}
