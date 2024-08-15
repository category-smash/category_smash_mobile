import 'package:bloc/bloc.dart';
import 'package:category_smash/core/entities/category.dart';
import 'package:category_smash/core/entities/question.dart';
import 'package:category_smash/domain/repositories/category_repository.dart';
import 'package:category_smash/presentation/lobby/views/select_category/views/add_category/views/add_question/add_question_page.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit({
    required this.categoryRepository,
    required this.router,
  }) : super(AddCategoryState.initial());

  final CategoryRepository categoryRepository;
  final GoRouter router;

  Future<void> addCategory(
    String name,
    String imageUrl,
  ) async {
    if (state.questions.isEmpty) {
      emit(
        AddCategoryState(
          isLoading: false,
          error: 'Musisz dodać pytania',
          questions: state.questions,
        ),
      );
      return;
    }
    emit(
      AddCategoryState(
        isLoading: true,
        error: null,
        questions: state.questions,
      ),
    );
    final category = Category(
      name: name,
      imageUrl: imageUrl,
      questions: state.questions,
    );
    try {
      await categoryRepository.addCategory(category);
      router.pop(category);
    } catch (e) {
      emit(
        AddCategoryState(
          isLoading: false,
          error: e.toString(),
          questions: state.questions,
        ),
      );
      return;
    }
  }

  Future<void> addQuestion() async {
    final questions = List<Question>.from(state.questions);
    emit(AddCategoryState(isLoading: true, error: null, questions: questions));
    final newQuestion = await router.pushNamed<Question>(
      AddQuestionPage.name,
    );
    if (newQuestion != null) {
      questions.add(newQuestion);
    }
    emit(
      AddCategoryState(
        isLoading: false,
        error: null,
        questions: questions,
      ),
    );
  }
}
