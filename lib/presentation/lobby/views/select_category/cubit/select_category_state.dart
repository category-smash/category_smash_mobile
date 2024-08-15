part of 'select_category_cubit.dart';

class SelectCategoryState extends Equatable {
  const SelectCategoryState({
    required this.categories,
    required this.isLoading,
  });

  factory SelectCategoryState.initial() {
    return const SelectCategoryState(
      categories: [],
      isLoading: true,
    );
  }

  final List<Category> categories;
  final bool isLoading;

  @override
  List<Object> get props => [categories, isLoading];
}
