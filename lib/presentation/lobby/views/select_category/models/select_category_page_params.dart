import 'package:category_smash/core/entities/player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'select_category_page_params.g.dart';

@JsonSerializable()
class SelectCategoryPageParams extends Equatable {
  const SelectCategoryPageParams({
    required this.players,
  });

  factory SelectCategoryPageParams.fromJson(Map<String, dynamic> json) =>
      _$SelectCategoryPageParamsFromJson(json);

  final List<Player> players;

  Map<String, dynamic> toJson() => _$SelectCategoryPageParamsToJson(this);

  @override
  List<Object?> get props => [players];
}
