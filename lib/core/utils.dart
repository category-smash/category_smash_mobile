import 'package:flutter/material.dart';

extension SnackExt on ScaffoldMessengerState {
  void showSnack(String text) {
    clearSnackBars();
    showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      ),
    );
  }
}
