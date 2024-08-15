import 'package:bloc/bloc.dart';
import 'package:category_smash/core/entities/category.dart';
import 'package:category_smash/domain/repositories/category_repository.dart';
import 'package:category_smash/presentation/lobby/views/select_category/views/add_category/add_category_page.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';

part 'select_category_state.dart';

class SelectCategoryCubit extends Cubit<SelectCategoryState> {
  SelectCategoryCubit({
    required this.categoryRepository,
    required this.router,
  }) : super(SelectCategoryState.initial());

  final CategoryRepository categoryRepository;
  final GoRouter router;

  void init() {
    final categories = categoryRepository.getCategories();
    emit(SelectCategoryState(categories: categories, isLoading: false));
  }

  Future<void> addCategory() async {
    final categories = state.categories;
    emit(SelectCategoryState(categories: categories, isLoading: true));
    final newCategory = await router.pushNamed<Category>(AddCategoryPage.name);
    if (newCategory == null) {
      emit(SelectCategoryState(categories: categories, isLoading: false));
      return;
    }
    final updatedCategories = [...categories, newCategory];
    emit(SelectCategoryState(categories: updatedCategories, isLoading: false));
  }

  Future<void> selectCategory(Category category) async {
    router.pop(category);
  }
}
