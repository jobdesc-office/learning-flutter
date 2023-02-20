import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_icon.dart';
import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

final _navigation = Get.find<NavigationPresenter>();

class ButtonEditDatatables extends BsButton {
  ButtonEditDatatables({
    required VoidCallback onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          prefixIcon: BaseIcon.buttonEdit,
          style: BsButtonStyle(
            backgroundColor: _navigation.darkTheme.value
                ? Colors.green.shade800
                : Colors.green.shade300,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          size: CustomButonSize.mini,
          onPressed: onPressed,
        );
}
