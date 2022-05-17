import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presenters/navigation_presenter.dart';
import 'color_palattes.dart';

final _navigation = Get.find<NavigationPresenter>();

class CustomButtonStyle {
  static BsButtonStyle get roundedPrimary => BsButtonStyle(
        backgroundColor: _navigation.darkTheme.value
            ? Colors.green.shade800
            : Colors.green.shade300,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      );

  static BsButtonStyle get roundedSecondary => BsButtonStyle(
        backgroundColor: ColorPallates.cancel,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      );

  static BsButtonStyle get roundedSafe => BsButtonStyle(
        backgroundColor: _navigation.darkTheme.value
            ? Colors.blue.shade800
            : Colors.blue.shade300,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      );

  static BsButtonStyle get roundedDanger => BsButtonStyle(
        backgroundColor: ColorPallates.tertiary,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      );

  static BsButtonStyle get roundedGrey => BsButtonStyle(
        backgroundColor: ColorPallates.delete,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      );

  static BsButtonStyle get roundedWarning => BsButtonStyle(
        backgroundColor: ColorPallates.warning,
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      );
}
