import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

import '../../constants/base_icon.dart';
import '../../constants/base_text.dart';
import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

class ThemeButtonCreate extends BsButton {
  ThemeButtonCreate({
    required VoidCallback onPressed,
    String? prefix,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          label: Text('${BaseText.buttonCreate} $prefix'),
          prefixIcon: BaseIcon.buttonCreate,
          style: CustomButtonStyle.roundedPrimary,
          size: CustomButonSize.medium,
          onPressed: onPressed,
        );
}
