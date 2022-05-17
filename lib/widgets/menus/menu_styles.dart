import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';
import '../../styles/color_palattes.dart';

class MenuStyles {
  final MenuDecoration decoration;
  final MenuTextStyle textStyle;

  MenuStyles({required this.decoration, required this.textStyle});

  factory MenuStyles.dark() {
    final _navigation = Get.find<NavigationPresenter>();
    return MenuStyles(
      decoration: MenuDecoration(
        active: BoxDecoration(
          color: ColorPallates.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        nonactive: BoxDecoration(),
      ),
      textStyle: MenuTextStyle(
        active: TextStyle(
          color: Colors.black,
        ),
        nonactive: TextStyle(
          color: _navigation.darkTheme.value ? Colors.white : Colors.black,
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
  final active;
  final nonactive;

  MenuTextStyle({required this.active, required this.nonactive});
}
