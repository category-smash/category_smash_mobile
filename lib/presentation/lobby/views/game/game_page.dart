import 'package:category_smash/presentation/lobby/views/game/cubit/game_cubit.dart';
import 'package:category_smash/presentation/lobby/widgets/player_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
  });

  static const String name = 'game';
  static const String path = 'game';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gra')),
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      state.category.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (int i = 0; i < state.players.length; i++)
                            PlayerTile(
                              player: state.players.keys.elementAt(i),
                              selected:
                                  state.roundIndex == i % state.players.length,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Zakończ grę'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
