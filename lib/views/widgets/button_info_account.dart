import 'package:boilerplate/constants/color_palattes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonInfoAccount extends StatelessWidget {
  const ButtonInfoAccount(
    this.text, {
    Key? key,
  }) : super(key: key);

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
        onTap: () {},
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }

  final String text;
}
