import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final List<Widget> content;

  const Body({super.key, required this.content});

  @override
  State<Body> createState() => _Body();
}

class _Body extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Column(
                  children: widget.content,
                ))));
  }
}
