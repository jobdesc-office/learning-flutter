import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

import '../../constants/base_icon.dart';
import '../../constants/base_text.dart';
import '../../styles/custom_button_size.dart';
import '../../styles/custom_button_styles.dart';

class ThemeButtonSave extends BsButton {
  ThemeButtonSave({
    required VoidCallback onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    bool disabled = false,
    bool processing = false,
  }) : super(
          disabled: disabled,
          margin: margin,
          label: !processing
              ? Text(BaseText.buttonSave)
              : Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(BaseText.processing),
                  ],
                ),
          prefixIcon: !processing ? BaseIcon.buttonSave : null,
          style: CustomButtonStyle.roundedPrimary,
          size: CustomButonSize.medium,
          onPressed: onPressed,
        );
}
