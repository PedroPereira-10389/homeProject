import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinnerWidget extends StatefulWidget {
  final bool isLoading;
  const SpinnerWidget({super.key, required this.isLoading});

  @override
  State<SpinnerWidget> createState() => _SpinnerWidget();
}

class _SpinnerWidget extends State<SpinnerWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return SpinKitFadingCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.red : Colors.green,
            ),
          );
        },
      );
    }
    return Container();
  }
}
