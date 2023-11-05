import 'package:flutter/material.dart';

void showEmailNotExistSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: message == "Account Created successfully" ||
                message == "Logout successfully" ||
                message == "Login Successfully"
            ? const TextStyle(color: Colors.green)
            : const TextStyle(color: Colors.red),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}
