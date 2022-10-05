import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';

final _navigation = Get.find<NavigationPresenter>();

class CustomInput extends BsInput {
  CustomInput({
    required TextEditingController controller,
    bool disabled = false,
    bool passwordText = false,
    bool readOnly = false,
    String? hintText,
    ValueChanged<String>? onChange,
    List<BsInputValidator> validators = const [],
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters = const [],
    int? maxLines,
    int? minLines,
  }) : super(
          obscureText: passwordText,
          disabled: disabled,
          readOnly: readOnly,
          controller: controller,
          hintText: hintText,
          validators: validators,
          onChange: onChange,
          style: BsInputStyle(
            disabledColor: _navigation.darkTheme.value
                ? Colors.grey.shade800
                : Color(0xffe7e7e7),
            backgroundColor: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            border: Border.all(
                color: _navigation.darkTheme.value
                    ? Colors.white
                    : ColorPallates.dark),
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
          minLines: minLines,
          maxLines: maxLines,
        );
}
