import 'package:category_smash/core/entities/question.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  const Category({
    required this.name,
    this.imageUrl,
    this.questions = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  final String name;
  final String? imageUrl;
  final List<Question> questions;

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [name, imageUrl, questions];
}
