import 'package:flutter/material.dart';

class FormGroup extends StatelessWidget {
  FormGroup({Key? key, required this.child, this.label}) : super(key: key);

  final Widget? label;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
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
