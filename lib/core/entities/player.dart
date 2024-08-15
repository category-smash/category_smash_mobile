import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Player extends Equatable {
  const Player({
    required this.name,
    required this.color,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  final String name;
  final int color;

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  @override
  List<Object?> get props => [name, color];
}
