import 'package:category_smash/core/entities/player.dart';
import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({
    required this.player,
    this.selected = false,
    super.key,
  });

  final Player player;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox.square(
          dimension: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? Colors.black : Colors.transparent,
                width: 2,
              ),
              color: Color(player.color),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(player.name),
      ],
    );
  }
}
