import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

import '../styles/color_palattes.dart';

class LoginButton extends BsButton {
  LoginButton({
    required VoidCallback onPressed,
    double? width,
    Widget? label,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          width: width,
          label: label,
          onPressed: onPressed,
          style: BsButtonStyle(
            color: Colors.white,
            backgroundColor: ColorPallates.dark,
            borderRadius: BorderRadius.circular(5),
          ),
          size: BsButtonSize(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          ),
        );
}
