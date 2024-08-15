part of 'add_category_cubit.dart';

final class AddCategoryState extends Equatable {
  const AddCategoryState({
    required this.isLoading,
    required this.error,
    required this.questions,
  });

  factory AddCategoryState.initial() {
    return const AddCategoryState(
      isLoading: false,
      error: null,
      questions: [],
    );
  }

  final bool isLoading;
  final String? error;
  final List<Question> questions;

  @override
  List<Object?> get props => [isLoading, error, questions];
}
