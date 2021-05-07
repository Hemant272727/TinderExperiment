import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  TextWidget({this.text});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
