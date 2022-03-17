import 'package:flutter/material.dart';

import '../../styles/color_palattes.dart';

class ButtonInfoAccount extends StatelessWidget {
  const ButtonInfoAccount(
    this.text, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final String text;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ColorPallates.danger,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
        onTap: this.onPressed,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
