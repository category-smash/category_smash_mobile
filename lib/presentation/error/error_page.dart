import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    this.message,
  });

  static const String name = 'error';
  static const String path = '/error';

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Błąd')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 100),
              const SizedBox(height: 20),
              Text(message ?? 'Wystąpił błąd'),
            ],
          ),
        ),
      ),
    );
  }
}
