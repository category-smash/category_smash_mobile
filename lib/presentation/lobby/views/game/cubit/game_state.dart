part of 'game_cubit.dart';

final class GameState extends Equatable {
  const GameState({
    required this.players,
    required this.category,
    required this.currentPlayerIndex,
    required this.gameMessage,
  });

  final List<Player> players;
  final Category category;
  final int currentPlayerIndex;
  final String? gameMessage;

  @override
  List<Object?> get props => [
        players,
        category,
        currentPlayerIndex,
        gameMessage,
      ];
}

final class GameInitial extends GameState {
  const GameInitial({
    required this.players,
    required this.category,
  });

  final List<Player> players;
  final Category category;

  @override
  List<Object?> get props => [players, category];
}

final class GameNextRound extends GameState {
  const GameNextRound({
    required this.currentPlayer,
    required this.nextPlayer,
    required this.question,
    required this.timeLeft,
  });

  final Player currentPlayer;
  final Player nextPlayer;
  final Question question;
  final int timeLeft;

  @override
  List<Object?> get props => [currentPlayer, nextPlayer, question, timeLeft];
}

final class GameEnded extends GameState {
  const GameEnded({
    required this.results,
  });

  final List<(Player player, int answeredQuestions)> results;

  @override
  List<Object?> get props => [results];
}
