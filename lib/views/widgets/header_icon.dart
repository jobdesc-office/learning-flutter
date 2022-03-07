import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({
    Key? key,
    required this.icon,
    required this.onPress,
    this.color = Colors.transparent,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: this.color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              this.icon,
              size: 22,
            ),
          ),
          borderRadius: BorderRadius.circular(5),
          onTap: this.onPress,
        ),
      ),
    );
  }

  final IconData icon;

  final Color color;

  final EdgeInsetsGeometry margin;

  final VoidCallback onPress;
}
