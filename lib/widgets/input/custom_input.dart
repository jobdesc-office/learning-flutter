import 'package:Ventes/styles/color_palattes.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends BsInput {
  CustomInput({
    required TextEditingController controller,
    bool disabled = false,
    bool passwordText = false,
    String? hintText,
    List<BsInputValidator> validators = const [],
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters = const [],
  }) : super(
          obscureText: passwordText,
          disabled: disabled,
          controller: controller,
          hintText: hintText,
          validators: validators,
          style: BsInputStyle(
            backgroundColor: Colors.white,
            border: Border.all(color: ColorPallates.dark),
            borderRadius: BorderRadius.circular(5),
            boxShadowFocused: [
              BoxShadow(
                color: ColorPallates.dark.withOpacity(.5),
                offset: Offset(0, 0),
                spreadRadius: 2.5,
              )
            ],
          ),
          size: BsInputSize(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        );
}
