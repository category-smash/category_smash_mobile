import 'package:category_smash/core/utils.dart';
import 'package:category_smash/core/widgets/loading_overlay.dart';
import 'package:category_smash/presentation/lobby/cubit/lobby_cubit.dart';
import 'package:category_smash/presentation/lobby/widgets/player_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LobbyPage extends StatelessWidget {
  const LobbyPage({super.key});

  static const String name = 'lobby';
  static const String path = '/';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LobbyCubit, LobbyState>(
      listener: (context, state) {
        final error = state.error ?? '';
        if (error.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnack(error);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Gracze:',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final player in state.players)
                                  PlayerTile(player: player),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (state.category == null)
                              const Text('Kategoria: brak')
                            else
                              Text('Kategoria: ${state.category?.name}'),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () => _onAddPlayerPressed(context),
                                  child: const Text('Dodaj gracza'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () =>
                                      _onSelectCategoryPressed(context),
                                  child: const Text('Wybierz kategorię'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () =>
                                      _onClearLocalStorageTapped(context),
                                  child: const Text('Usuń wszystkie kategorie'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: state.players.length >= 2 &&
                                      state.category != null
                                  ? () => _onStartGameTapped(context)
                                  : null,
                              child: const Text('Rozpocznij grę'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.isLoading) const LoadingOverlay(),
          ],
        );
      },
    );
  }

  void _onAddPlayerPressed(BuildContext context) {
    context.read<LobbyCubit>().addPlayer();
  }

  void _onSelectCategoryPressed(BuildContext context) {
    context.read<LobbyCubit>().selectCategory();
  }

  void _onClearLocalStorageTapped(BuildContext context) {
    context.read<LobbyCubit>().clearLocalStorage();
  }

  void _onStartGameTapped(BuildContext context) {
    context.read<LobbyCubit>().startGame();
  }
}
