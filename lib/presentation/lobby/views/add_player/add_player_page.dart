import 'package:category_smash/core/entities/player.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddPlayerPage extends StatefulWidget {
  const AddPlayerPage({
    super.key,
  });

  static const String name = 'add_player';
  static const String path = 'add-player';

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Color _selectedColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dodawanie gracza')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Wprowadź nazwę gracza';
                                }
                                return null;
                              },
                              controller: _nameController,
                              enabled: true,
                              decoration: const InputDecoration(
                                labelText: 'Nazwa gracza',
                              ),
                            ),
                            const SizedBox(height: 16),
                            ColorPicker(
                              color: _selectedColor,
                              title: const Text('Wybierz kolor gracza'),
                              pickersEnabled: const {
                                ColorPickerType.primary: true,
                                ColorPickerType.accent: false,
                              },
                              onColorChanged: _onColorChanged,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Material(
              elevation: 1,
              color: Theme.of(context).colorScheme.primary,
              child: InkWell(
                onTap: _onSave,
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Dodaj',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onColorChanged(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text;
      final player = Player(name: name, color: _selectedColor.value);
      context.pop(player);
    }
  }
}
