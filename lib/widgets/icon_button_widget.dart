import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtunWidget extends StatelessWidget {
  final IconData icon;
  final int index;
  final int value;
  final Function onPressed;
  const IconButtunWidget(
      {@required this.icon,
      @required this.index,
      @required this.value,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: index == value ? Colors.green[400] : Colors.grey[400],
      ),
      onPressed: onPressed,
    );
  }
}
