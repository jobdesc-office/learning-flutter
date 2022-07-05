import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

import '../../constants/base_icon.dart';
import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

class ButtonCheckDatatables extends BsButton {
  ButtonCheckDatatables({
    required VoidCallback onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          prefixIcon: BaseIcon.buttonCheck,
          style: CustomButtonStyle.roundedPrimary,
          size: CustomButonSize.mini,
          onPressed: onPressed,
        );
}
