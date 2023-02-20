import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_icon.dart';
import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

final _navigation = Get.find<NavigationPresenter>();

class ButtonDeleteDatatables extends BsButton {
  ButtonDeleteDatatables({
    required VoidCallback onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          prefixIcon: BaseIcon.buttonDelete,
          style: BsButtonStyle(
            backgroundColor: ColorPallates.delete,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          size: CustomButonSize.mini,
          onPressed: onPressed,
        );
}
