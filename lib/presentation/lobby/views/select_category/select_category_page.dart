import 'package:category_smash/core/widgets/loading_overlay.dart';
import 'package:category_smash/presentation/lobby/views/select_category/cubit/select_category_cubit.dart';
import 'package:category_smash/presentation/lobby/views/select_category/models/select_category_page_params.dart';
import 'package:category_smash/presentation/lobby/views/select_category/widget/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCategoryPage extends StatelessWidget {
  const SelectCategoryPage({
    required this.params,
    super.key,
  });

  final SelectCategoryPageParams params;

  static const String name = 'select_category';
  static const String path = 'select-category';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCategoryCubit, SelectCategoryState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text('Wybierz kategorię'),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final category in state.categories)
                      CategoryTile(category: category),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:
                          context.read<SelectCategoryCubit>().addCategory,
                      child: const Text('Dodaj kategorię'),
                    ),
                  ],
                ),
              ),
            ),
            if (state.isLoading) const LoadingOverlay(),
          ],
        );
      },
    );
  }
}
