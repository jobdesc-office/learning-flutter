import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presenters/navigation_presenter.dart';
import 'color_palattes.dart';

final _navigation = Get.find<NavigationPresenter>();

class ThemeDatatablesStyles {
  static InputDecoration searchInputDecoration(
          {String hintText = 'Search ...'}) =>
      InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w100,
          color: Colors.grey,
        ),
        isDense: true,
      );
}
