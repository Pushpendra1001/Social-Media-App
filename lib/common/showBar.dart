import 'package:flutter/material.dart';

void showBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: message == "Account Created successfully"
            ? const TextStyle(color: Colors.green)
            : const TextStyle(color: Colors.red),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}
