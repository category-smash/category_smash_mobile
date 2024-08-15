import 'dart:convert';

import 'package:category_smash/core/entities/category.dart';
import 'package:category_smash/domain/repositories/category_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl({
    required this.sharedPrefs,
  });

  final SharedPreferences sharedPrefs;

  static const _categoriesKey = 'categories';

  @override
  List<Category> getCategories() {
    final categories = sharedPrefs
        .getStringList(_categoriesKey)
        ?.map(
          (e) => Category.fromJson(
            jsonDecode(e) as Map<String, dynamic>,
          ),
        )
        .toList();

    return categories ?? [];
  }

  @override
  Category getCategory(String name) {
    final categories = getCategories();
    final category = categories.firstWhere(
      (element) => element.name == name,
      orElse: () => throw Exception('Category "$name" not found'),
    );
    return category;
  }

  @override
  Future<void> addCategory(Category category) async {
    final categories = getCategories();
    final categoryExists =
        categories.any((element) => element.name == category.name);
    if (categoryExists) {
      throw Exception('Category "${category.name}" already exists');
    }
    categories.add(category);
    final categoriesJson =
        categories.map((e) => jsonEncode(e.toJson())).toList();
    await sharedPrefs.setStringList(_categoriesKey, categoriesJson);
  }

  @override
  Future<void> clearCategories() async {
    await sharedPrefs.remove(_categoriesKey);
  }
}
