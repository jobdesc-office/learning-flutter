import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

import 'color_palattes.dart';

class CustomButtonStyle {
  static BsButtonStyle get roundedPrimary => BsButtonStyle(
        backgroundColor: ColorPallates.dark,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      );

  static BsButtonStyle get roundedDanger => BsButtonStyle(
        backgroundColor: ColorPallates.danger,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      );
}
