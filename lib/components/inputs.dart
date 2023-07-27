import 'dart:async';

import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  const InputWidget({super.key, required this.label, required this.hint, required this.controller, required this.isPassword});

  @override
  State<InputWidget> createState() => _InputWidget();
}

class _InputWidget extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        obscureText: widget.isPassword,
        controller: widget.controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.label,
            hintText: widget.hint),
      ),
    );
  }
}
