import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_icon.dart';
import '../../constants/base_text.dart';
import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

class ThemeButtonBack extends BsButton {
  ThemeButtonBack({
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
  }) : super(
            disabled: disabled,
            margin: margin,
            label: Text(BaseText.buttonBack),
            prefixIcon: BaseIcon.buttonBack,
            style: CustomButtonStyle.back,
            size: CustomButonSize.medium,
            onPressed: () => Get.back());
}
