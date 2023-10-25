import 'dart:async';

import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  const InputWidget(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
      required this.isPassword,
      required this.validator});

  @override
  State<InputWidget> createState() => _InputWidget();
}

class _InputWidget extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        obscureText: widget.isPassword,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.label,
            hintText: widget.hint),
      ),
    );
  }
}
