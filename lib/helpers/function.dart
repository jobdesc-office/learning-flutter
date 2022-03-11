import 'package:boilerplate/presenters/auth_presenter.dart';
import 'package:get/get.dart';

import '../presenters/navigation_presenter.dart';

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

void toNameRoute(String name) {
  final navigation = Get.find<NavigationPresenter>();
  final authPresenter = Get.find<AuthPresenter>();

  navigation.to(name);
}
