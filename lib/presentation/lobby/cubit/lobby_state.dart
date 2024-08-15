part of 'lobby_cubit.dart';

final class LobbyState extends Equatable {
  const LobbyState({
    required this.players,
    required this.isLoading,
    required this.category,
    required this.error,
  });

  factory LobbyState.initial() {
    return const LobbyState(
      players: [],
      isLoading: false,
      category: null,
      error: null,
    );
  }

  final List<Player> players;
  final bool isLoading;
  final Category? category;
  final String? error;

  @override
  List<Object?> get props => [
        players,
        isLoading,
        category,
        error,
      ];
}
