import 'package:category_smash/core/entities/category.dart';
import 'package:category_smash/core/entities/player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_page_params.g.dart';

@JsonSerializable()
class GamePageParams extends Equatable {
  const GamePageParams({
    required this.category,
    required this.players,
  });

  factory GamePageParams.fromJson(Map<String, dynamic> json) =>
      _$GamePageParamsFromJson(json);

  final Category category;
  final List<Player> players;

  Map<String, dynamic> toJson() => _$GamePageParamsToJson(this);

  @override
  List<Object?> get props => [category, players];
}
