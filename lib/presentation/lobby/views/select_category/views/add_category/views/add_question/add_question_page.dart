import 'package:category_smash/core/entities/question.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key});

  static const String path = 'add-question';
  static const String name = 'add_question';

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();

  final _imageUrlController = TextEditingController();
  final _correctAnswerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dodawanie pytania')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('URL do obrazka'),
                  ),
                  controller: _imageUrlController,
                  validator: (v) {
                    if (v == null) return 'URL nie moze być pusty';
                    final uri = Uri.tryParse(v);
                    if (uri == null || uri.host.isEmpty || uri.scheme.isEmpty) {
                      return 'Niepoprawny URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Poprawna odpowiedź'),
                  ),
                  controller: _correctAnswerController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Odpowiedź nie moze być pusta';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Dodaj pytanie'),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.pop(
                        Question(
                          imageUrl: _imageUrlController.text,
                          correctAnswer: _correctAnswerController.text,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
