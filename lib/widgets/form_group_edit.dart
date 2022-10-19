import 'package:flutter/material.dart';

class FormGroupEdit extends StatelessWidget {
  FormGroupEdit({Key? key, required this.child, this.label}) : super(key: key);

  final Widget? label;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: label,
            ),
          ),
          Container(
            child: child,
          )
        ],
      ),
    );
  }
}
