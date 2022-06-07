import 'package:boilerplate/styles/color_palattes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';

final NavigationPresenter _navigation = Get.find<NavigationPresenter>();

class TextDatatableColumn extends Text {
  TextDatatableColumn(String title)
      : super(title,
            style: TextStyle(
                color: _navigation.darkTheme.value
                    ? Colors.grey
                    : ColorPallates.primary));
}
