import 'package:boilerplate/constants/color_palattes.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

class CustomButtonStyle {
  static BsButtonStyle get roundedPrimary => BsButtonStyle(
        backgroundColor: ColorPallates.dark,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      );
}
