import 'package:bloc/bloc.dart';
import 'package:category_smash/core/entities/category.dart';
import 'package:category_smash/core/entities/player.dart';
import 'package:category_smash/domain/repositories/category_repository.dart';
import 'package:category_smash/presentation/lobby/views/add_player/add_player_page.dart';
import 'package:category_smash/presentation/lobby/views/game/game_page.dart';
import 'package:category_smash/presentation/lobby/views/game/models/game_page_params.dart';
import 'package:category_smash/presentation/lobby/views/select_category/models/select_category_page_params.dart';
import 'package:category_smash/presentation/lobby/views/select_category/select_category_page.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';

part 'lobby_state.dart';

class LobbyCubit extends Cubit<LobbyState> {
  LobbyCubit({
    required this.router,
    required this.categoryRepository,
  }) : super(LobbyState.initial());

  final GoRouter router;
  final CategoryRepository categoryRepository;

  Future<void> addPlayer() async {
    final players = state.players;
    emit(
      LobbyState(
        players: players,
        isLoading: true,
        category: state.category,
        error: null,
      ),
    );
    final newPlayer = await router.pushNamed<Player>(AddPlayerPage.name);
    if (newPlayer == null) {
      emit(
        LobbyState(
          players: players,
          isLoading: false,
          category: state.category,
          error: null,
        ),
      );
      return;
    }
    final newPlayers = [...players, newPlayer];
    emit(
      LobbyState(
        players: newPlayers,
        isLoading: false,
        category: state.category,
        error: null,
      ),
    );
  }

  Future<void> selectCategory() async {
    emit(
      LobbyState(
        players: state.players,
        isLoading: true,
        category: state.category,
        error: null,
      ),
    );
    final newCategory = await router.pushNamed<Category>(
      SelectCategoryPage.name,
      extra: SelectCategoryPageParams(
        players: state.players,
      ).toJson(),
    );
    if (newCategory == null) {
      emit(
        LobbyState(
          players: state.players,
          isLoading: false,
          category: state.category,
          error: null,
        ),
      );
      return;
    }

    emit(
      LobbyState(
        players: state.players,
        isLoading: false,
        category: newCategory,
        error: null,
      ),
    );
  }

  Future<void> clearLocalStorage() async {
    await categoryRepository.clearCategories();
    emit(
      LobbyState(
        players: state.players,
        isLoading: state.isLoading,
        category: null,
        error: null,
      ),
    );
  }

  void startGame() {
    final category = state.category;
    final players = state.players;
    if (category == null || players.isEmpty) {
      emit(
        LobbyState(
          players: state.players,
          isLoading: state.isLoading,
          category: state.category,
          error: 'Musisz wybrać kategorię i dodać co najmniej dwóch graczy.',
        ),
      );
      return;
    }
    router.pushNamed(
      GamePage.name,
      extra: GamePageParams(
        category: category,
        players: players,
      ).toJson(),
    );
  }
}
