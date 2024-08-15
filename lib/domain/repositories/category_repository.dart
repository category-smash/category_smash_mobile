import 'package:category_smash/core/entities/category.dart';

abstract interface class CategoryRepository {
  List<Category> getCategories();
  Category getCategory(String id);
  Future<void> addCategory(Category category);
  Future<void> clearCategories();
}
