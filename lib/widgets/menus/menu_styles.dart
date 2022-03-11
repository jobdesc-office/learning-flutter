import 'package:flutter/material.dart';

import '../../../constants/color_palattes.dart';

class MenuStyles {
  final MenuDecoration decoration;
  final MenuTextStyle textStyle;

  MenuStyles({required this.decoration, required this.textStyle});

  factory MenuStyles.dark() {
    return MenuStyles(
      decoration: MenuDecoration(
        active: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        nonactive: BoxDecoration(),
      ),
      textStyle: MenuTextStyle(
        active: TextStyle(
          color: ColorPallates.dark,
        ),
        nonactive: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class MenuDecoration {
  final BoxDecoration active;
  final BoxDecoration nonactive;

  MenuDecoration({required this.active, required this.nonactive});
}

class MenuTextStyle {
  final TextStyle active;
  final TextStyle nonactive;

  MenuTextStyle({required this.active, required this.nonactive});
}
