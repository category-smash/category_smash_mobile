// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_page_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GamePageParams _$GamePageParamsFromJson(Map<String, dynamic> json) =>
    GamePageParams(
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GamePageParamsToJson(GamePageParams instance) =>
    <String, dynamic>{
      'category': instance.category.toJson(),
      'players': instance.players.map((e) => e.toJson()).toList(),
    };
