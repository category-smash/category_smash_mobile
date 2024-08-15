// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_category_page_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectCategoryPageParams _$SelectCategoryPageParamsFromJson(
        Map<String, dynamic> json) =>
    SelectCategoryPageParams(
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SelectCategoryPageParamsToJson(
        SelectCategoryPageParams instance) =>
    <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
    };
