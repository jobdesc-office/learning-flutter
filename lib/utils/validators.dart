import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';

class Validators {
  static BsInputValidator inputRequired(String field) {
    return BsInputValidator(validator: (value) {
      String valueValidate = value.toString().trim();
      if (valueValidate.isEmpty || value == null) return '$field is required';

      return null;
    });
  }

  static BsInputValidator inputEmail() {
    return BsInputValidator(validator: (value) {
      RegExp regExp = RegExp(
          r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
          caseSensitive: false,
          multiLine: false);
      if (!value.toString().contains('@'))
        return "Invalid email, email must contain @ symbol";
      else if (!regExp.hasMatch(value))
        return "Invalid email, double check your email";

      return null;
    });
  }

  static BsInputValidator maxLength(String field, int length) {
    return BsInputValidator(validator: (value) {
      if (value.toString().length > length)
        return "$field cannot be more than $length digit";
      return null;
    });
  }

  static BsInputValidator minLength(String field, int length) {
    return BsInputValidator(validator: (value) {
      if (value.toString().length < length)
        return "$field cannot be less than $length digit";
      return null;
    });
  }

  static BsSelectValidator selectRequired(String field) {
    return BsSelectValidator(validator: (value) {
      String valueValidate = value.toString().trim();
      if (valueValidate.isEmpty || value == null) return '$field is required';

      return null;
    });
  }
}
