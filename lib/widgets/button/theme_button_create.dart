import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

import '../../constants/base_icon.dart';
import '../../constants/base_text.dart';
import '../../styles/custom_button_size.dart';

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
          style: BsButtonStyle(
            backgroundColor: ColorPallates.primary,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          size: CustomButonSize.medium,
          onPressed: onPressed,
        );
}
