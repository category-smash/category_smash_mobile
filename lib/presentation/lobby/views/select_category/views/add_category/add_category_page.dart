import 'package:category_smash/core/utils.dart';
import 'package:category_smash/core/widgets/loading_overlay.dart';
import 'package:category_smash/presentation/lobby/views/select_category/views/add_category/cubit/add_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({
    super.key,
  });

  static const String name = 'add_category';
  static const String path = 'add-category';

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCategoryCubit, AddCategoryState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text('Dodawanie kategorii')),
              body: BlocListener<AddCategoryCubit, AddCategoryState>(
                listener: (context, state) {
                  final error = state.error;
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnack(error);
                  }
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text(
                                'Nazwa kategorii',
                              ),
                            ),
                            controller: _categoryController,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return 'Nazwa kategorii nie może być pusta';
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text('URL do obrazka'),
                            ),
                            controller: _imageUrlController,
                            validator: (value) {
                              if (value == null || value.isEmpty) return null;
                              final uri = Uri.tryParse(value);
                              if (uri == null ||
                                  uri.scheme.isEmpty ||
                                  uri.host.isEmpty) {
                                return 'Niepoprawny adres URL';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.questions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.network(
                                  state.questions[index].imageUrl,
                                ),
                                title: Text(
                                  state.questions[index].correctAnswer,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => _onAddCategoryTapped(context),
                                child: const Text('Dodaj kategorię'),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () => _onAddQuestionTapped(context),
                                child: const Text('Dodaj pytanie'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (state.isLoading) const LoadingOverlay(),
          ],
        );
      },
    );
  }

  void _onAddCategoryTapped(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AddCategoryCubit>().addCategory(
            _categoryController.text,
            _imageUrlController.text,
          );
    }
  }

  void _onAddQuestionTapped(BuildContext context) {
    context.read<AddCategoryCubit>().addQuestion();
  }
}
