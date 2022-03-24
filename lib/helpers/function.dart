import 'package:get/get.dart';

import '../presenters/navigation_presenter.dart';

String notNull(dynamic value, {String? nullValue}) {
  String newValue = value.toString();
  if (value == null && nullValue != null)
    newValue = nullValue;
  else if (value == null && nullValue == null)
    newValue = '';
  else if (value != null && value == '' && nullValue != null)
    newValue = nullValue;

  return newValue;
}

double parseDouble(dynamic value, {int decimal = 2}) {
  return value == null ? 0.0 : double.parse(value.toString());
}

int parseInt(dynamic value) {
  return value == null ? 0 : int.parse(value.toString());
}

String parseString(dynamic value) {
  return value == null ? '' : value.toString();
}

DateTime? parseDate(dynamic value) {
  return value == null ? null : DateTime.parse(value.toString());
}

bool parseBool(dynamic value) {
  return value == null
      ? false
      : (value is String)
          ? value == 'true'
              ? true
              : false
          : value;
}

void toNameRoute(String name, {bool pushReplace = false}) {
  final navigation = Get.find<NavigationPresenter>();

  navigation.to(name, pushReplace: pushReplace);
}
