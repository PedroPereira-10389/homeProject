import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  final List<Widget> inputs;
  const FormWidget({super.key, required this.inputs});

  @override
  State<FormWidget> createState() => _FormWidget();
}

class _FormWidget extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.inputs
    );
  }
}
