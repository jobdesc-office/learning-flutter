import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

import '../../constants/base_icon.dart';
import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

class ButtonEditDatatables extends BsButton {
  ButtonEditDatatables({
    required VoidCallback onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          prefixIcon: BaseIcon.buttonEdit,
          style: CustomButtonStyle.roundedPrimary,
          size: CustomButonSize.small,
          onPressed: onPressed,
        );
}
