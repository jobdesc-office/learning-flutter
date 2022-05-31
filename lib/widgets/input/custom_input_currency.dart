import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_input.dart';

class CustomInputCurrency extends CustomInput {
  CustomInputCurrency({
    required TextEditingController controller,
    bool disabled = false,
    bool readOnly = false,
    String? hintText,
    List<BsInputValidator> validators = const [],
    List<TextInputFormatter>? inputFormatters = const [],
    int? maxLines,
    int? minLines,
    ValueChanged<String>? onChange,
  }) : super(
          disabled: disabled,
          readOnly: readOnly,
          controller: controller,
          hintText: hintText,
          validators: validators,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyTextInputFormatter(
              decimalDigits: 0,
              symbol: '',
            )
          ],
          minLines: minLines,
          maxLines: maxLines,
          onChange: onChange,
        );
}
