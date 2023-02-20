import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../constants/base_icon.dart';
import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

final _navigation = Get.find<NavigationPresenter>();

class ButtonDetailsDatatables extends BsButton {
  ButtonDetailsDatatables({
    required VoidCallback onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          prefixIcon: BaseIcon.buttonDetail,
          style: BsButtonStyle(
            backgroundColor: _navigation.darkTheme.value
                ? Colors.blue.shade800
                : Colors.blue.shade300,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          size: CustomButonSize.mini,
          onPressed: onPressed,
        );
}
