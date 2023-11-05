import 'package:flutter/material.dart';

class textFieldInput extends StatelessWidget {
  final controller;
  final String hint_text;
  final bool obscuretext;

  const textFieldInput({
    super.key,
    this.controller,
    required this.hint_text,
    required this.obscuretext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600)),
          border: const OutlineInputBorder(),
          hintText: hint_text,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        obscureText: obscuretext,
      ),
    );
  }
}
