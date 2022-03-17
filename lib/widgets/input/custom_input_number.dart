import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_input.dart';

class CustomInputNumber extends CustomInput {
  CustomInputNumber({
    required TextEditingController controller,
    bool disabled = false,
    String? hintText,
    List<BsInputValidator> validators = const [],
  }) : super(
          disabled: disabled,
          controller: controller,
          hintText: hintText,
          validators: validators,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        );
}
