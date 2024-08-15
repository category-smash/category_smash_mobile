import 'package:category_smash/core/entities/category.dart';
import 'package:category_smash/presentation/lobby/views/select_category/cubit/select_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    required this.category,
    super.key,
  });

  final Category category;
  static const double size = 32;

  @override
  Widget build(BuildContext context) {
    final imageUrl = category.imageUrl;
    Widget leading;
    if (imageUrl == null) {
      leading = const Icon(Icons.category, size: 32, opticalSize: 32);
    } else {
      leading = Image.network(imageUrl, width: 32, height: 32);
    }
    return ListTile(
      leading: leading,
      trailing: Text('${category.questions.length} pytań'),
      title: Text(category.name),
      onTap: () => context.read<SelectCategoryCubit>().selectCategory(category),
    );
  }
}
