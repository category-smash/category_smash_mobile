import 'package:category_smash/bootstrap.dart';
import 'package:category_smash/data/repositories/category_repository_impl.dart';
import 'package:category_smash/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final categoryRepository = CategoryRepositoryImpl(
    sharedPrefs: await SharedPreferences.getInstance(),
  );
  await bootstrap(() => App(categoryRepository: categoryRepository));
}
