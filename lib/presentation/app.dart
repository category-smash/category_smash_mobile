import 'package:category_smash/domain/repositories/category_repository.dart';
import 'package:category_smash/presentation/error/error_page.dart';
import 'package:category_smash/presentation/lobby/cubit/lobby_cubit.dart';
import 'package:category_smash/presentation/lobby/lobby_page.dart';
import 'package:category_smash/presentation/lobby/views/add_player/add_player_page.dart';
import 'package:category_smash/presentation/lobby/views/game/cubit/game_cubit.dart';
import 'package:category_smash/presentation/lobby/views/game/game_page.dart';
import 'package:category_smash/presentation/lobby/views/game/models/game_page_params.dart';
import 'package:category_smash/presentation/lobby/views/select_category/cubit/select_category_cubit.dart';
import 'package:category_smash/presentation/lobby/views/select_category/models/select_category_page_params.dart';
import 'package:category_smash/presentation/lobby/views/select_category/select_category_page.dart';
import 'package:category_smash/presentation/lobby/views/select_category/views/add_category/add_category_page.dart';
import 'package:category_smash/presentation/lobby/views/select_category/views/add_category/cubit/add_category_cubit.dart';
import 'package:category_smash/presentation/lobby/views/select_category/views/add_category/views/add_question/add_question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({
    required this.categoryRepository,
    super.key,
  });

  final CategoryRepository categoryRepository;

  final router = GoRouter(
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
        path: LobbyPage.path,
        name: LobbyPage.name,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => LobbyCubit(
              router: context.read(),
              categoryRepository: context.read(),
            ),
            child: const LobbyPage(),
          );
        },
        routes: [
          GoRoute(
            path: AddPlayerPage.path,
            name: AddPlayerPage.name,
            builder: (context, state) {
              return const AddPlayerPage();
            },
          ),
          GoRoute(
            path: SelectCategoryPage.path,
            name: SelectCategoryPage.name,
            routes: [
              GoRoute(
                path: AddCategoryPage.path,
                name: AddCategoryPage.name,
                routes: [
                  GoRoute(
                    path: AddQuestionPage.path,
                    name: AddQuestionPage.name,
                    builder: (context, state) {
                      return const AddQuestionPage();
                    },
                  ),
                ],
                builder: (context, state) {
                  return BlocProvider(
                    create: (context) => AddCategoryCubit(
                      categoryRepository: context.read(),
                      router: context.read(),
                    ),
                    child: const AddCategoryPage(),
                  );
                },
              ),
            ],
            builder: (context, state) {
              final extra = state.extra! as Map<String, dynamic>;
              return BlocProvider(
                create: (context) => SelectCategoryCubit(
                  categoryRepository: context.read(),
                  router: context.read(),
                )..init(),
                child: SelectCategoryPage(
                  params: SelectCategoryPageParams.fromJson(extra),
                ),
              );
            },
          ),
          GoRoute(
            name: GamePage.name,
            path: GamePage.path,
            builder: (context, state) {
              final extra = state.extra! as Map<String, dynamic>;
              return BlocProvider(
                create: (context) => GameCubit(
                  params: GamePageParams.fromJson(extra),
                ),
                child: GamePage(),
              );
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: router,
      child: RepositoryProvider.value(
        value: categoryRepository,
        child: MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
