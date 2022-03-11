import 'package:boilerplate/utils/validators.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/color_palattes.dart';
import '../../widgets/form_group.dart';

class LoginForm {
  Widget username({required TextEditingController controller}) {
    return FormGroup(
      child: BsInput(
        style: BsInputStyle(
          border: Border.all(color: Color(0xffdedede)),
          backgroundColor: Color(0xffdedede),
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
        suffixIcon: CupertinoIcons.person,
        validators: [
          Validators.inputRequired('Username'),
        ],
      ),
    );
  }

  Widget password({
    required TextEditingController controller,
    bool obsecureText = true,
    VoidCallback? onTapSuffixIcon,
  }) {
    return FormGroup(
      child: BsInput(
        style: BsInputStyle(
          border: Border.all(color: Color(0xffdedede)),
          backgroundColor: Color(0xffdedede),
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
        suffixIcon: CupertinoIcons.eye,
        onTapSuffixIcon: onTapSuffixIcon,
        obscureText: obsecureText,
        validators: [
          Validators.inputRequired('Password'),
        ],
      ),
    );
  }
}
