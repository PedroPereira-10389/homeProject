import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final VoidCallback function;
  final String text;
  final Widget icon;
  const ButtonWidget(
      {super.key,
      required this.function,
      required this.text,
      required this.icon});

  @override
  State<ButtonWidget> createState() => _ButtonWidget();
}

class _ButtonWidget extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
                onPressed: widget.function,
                icon: widget.icon,
                label: Text(widget.text))));
  }
}
