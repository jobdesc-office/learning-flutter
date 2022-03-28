import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

class ButtonRoleUser extends BsButton {
  ButtonRoleUser({
    required VoidCallback onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          label: Text('Increase'),
          style: CustomButtonStyle.roundedPrimary,
          size: CustomButonSize.small,
          onPressed: onPressed,
        );
}

class ButtonRoleUser2 extends BsButton {
  ButtonRoleUser2({
    required VoidCallback onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          label: Text('Decrease'),
          style: CustomButtonStyle.roundedDanger,
          size: CustomButonSize.small,
          onPressed: onPressed,
        );
}
