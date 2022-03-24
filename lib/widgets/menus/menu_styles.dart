import 'package:flutter/material.dart';

import '../../styles/color_palattes.dart';

class MenuStyles {
  final MenuDecoration decoration;
  final MenuTextStyle textStyle;

  MenuStyles({required this.decoration, required this.textStyle});

  factory MenuStyles.dark() {
    return MenuStyles(
      decoration: MenuDecoration(
        active: BoxDecoration(
          color: ColorPallates.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
        nonactive: BoxDecoration(),
      ),
      textStyle: MenuTextStyle(
        active: TextStyle(
          color: Colors.black,
        ),
        nonactive: TextStyle(
          color: ColorPallates.dark,
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
