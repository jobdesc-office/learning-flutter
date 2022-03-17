import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

import '../../constants/base_icon.dart';
import '../../constants/base_text.dart';
import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

class ThemeButtonCancel extends BsButton {
  ThemeButtonCancel({
    required VoidCallback onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          label: Text(BaseText.buttonCancel),
          prefixIcon: BaseIcon.buttonCancel,
          style: CustomButtonStyle.roundedDanger,
          size: CustomButonSize.medium,
          onPressed: onPressed,
        );
}
