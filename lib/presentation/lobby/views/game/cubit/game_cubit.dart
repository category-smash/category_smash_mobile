import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:category_smash/core/entities/category.dart';
import 'package:category_smash/core/entities/player.dart';
import 'package:category_smash/core/entities/question.dart';
import 'package:category_smash/presentation/lobby/views/game/models/game_page_params.dart';
import 'package:equatable/equatable.dart';
import 'package:pausable_timer/pausable_timer.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required GamePageParams params,
  })  : _playerTimers = params.players.map((_) => null).toList(),
        super(
          GameState(
            players: params.players,
            category: params.category,
            currentPlayerIndex: 0,
            gameMessage: null,
          ),
        );

  final List<PausableTimer?> _playerTimers;
  final List<Player> killedPlayers = [];
  bool _willPause = false;

  /// Starts the game, runs the timer for the first player.
  void startGame() {
    for (var i = 0; i < _playerTimers.length; i++) {
      _playerTimers[i] = PausableTimer(const Duration(seconds: 60), _kill);
    }
    _startNextTurn();
  }

  /// Pauses the game after the current player's turn.
  void pauseGame() {
    _willPause = true;
  }

  void _startNextTurn() {
    if (_willPause) {
      _willPause = false;
      return;
    }
    _playerTimers[state.currentPlayerIndex]?.pause();
    final nextPlayerIndex =
        (state.currentPlayerIndex + 1) % state.players.length;
    _playerTimers[nextPlayerIndex]?.start();
    emit(
      GameState(
        players: state.players,
        category: state.category,
        currentPlayerIndex: nextPlayerIndex,
        gameMessage: null,
      ),
    );
  }

  /// Cancels the current players timer and
  /// removes the player from the player list.
  void _kill() {
    _playerTimers[state.currentPlayerIndex]?.cancel();
    final players = state.players;

    emit(
      GameState(
        players: players,
        category: state.category,
        currentPlayerIndex: state.currentPlayerIndex,
        gameMessage:
            'Gracz ${state.players[state.currentPlayerIndex].name} odpadł',
      ),
    );
    if (players.length == 1) {
      _playerTimers[0]?.cancel();
      emit(
        GameState(
          players: players,
          category: state.category,
          currentPlayerIndex: state.currentPlayerIndex,
          gameMessage: 'Wygrał gracz ${players.first.name}',
        ),
      );
    } else {
      _startNextTurn();
    }
  }

  @override
  Future<void> close() async {
    for (final timer in _playerTimers) {
      timer?.cancel();
    }
    return super.close();
  }
}
