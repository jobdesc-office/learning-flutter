import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:flutter/cupertino.dart';

import '../../styles/color_palattes.dart';
import '../../utils/validators.dart';
import '../../widgets/form_group.dart';

class LoginForm {
  Widget username({required TextEditingController controller}) {
    return FormGroup(
      child: BsInput(
        textInputAction: TextInputAction.next,
        autofocus: true,
        style: BsInputStyle(
          border: Border.all(color: Color(0xffdedede)),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(5),
          boxShadowFocused: [
            BoxShadow(
              color: ColorPallates.dark,
              offset: Offset(0, 0),
              spreadRadius: 0.5,
            )
          ],
        ),
        size: BsInputSize(
          padding: EdgeInsets.fromLTRB(15, 18, 15, 15),
          iconSize: 16,
          transisionFontSize: 3,
          transitionLabelY: -5,
          transitionLabelX: 7,
        ),
        controller: controller,
        hintTextLabel: 'Username',
        prefixIcon: CupertinoIcons.person,
        validators: [
          Validators.inputRequired('Username'),
        ],
      ),
    );
  }

  Widget password({
    required TextEditingController controller,
    bool obsecureText = true,
    IconData? suffixIcon,
    VoidCallback? onTapSuffixIcon,
    FormFieldSetter<String>? onFieldSubmitted,
  }) {
    return FormGroup(
      child: BsInput(
        obscureText: obsecureText,
        style: BsInputStyle(
          border: Border.all(color: Color(0xffdedede)),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(5),
          boxShadowFocused: [
            BoxShadow(
              color: ColorPallates.dark,
              offset: Offset(0, 0),
              spreadRadius: 0.5,
            )
          ],
        ),
        size: BsInputSize(
          padding: EdgeInsets.fromLTRB(15, 18, 15, 15),
          iconSize: 16,
          transisionFontSize: 3,
          transitionLabelY: -5,
          transitionLabelX: 7,
        ),
        controller: controller,
        hintTextLabel: 'Password',
        prefixIcon: CupertinoIcons.lock,
        suffixIcon: suffixIcon,
        validators: [
          Validators.inputRequired('Password'),
        ],
        onTapSuffixIcon: onTapSuffixIcon,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
