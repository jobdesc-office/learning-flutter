import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/masters/menus/_form_source.dart';
import '../../views/masters/menus/menu_form.dart';

class MenuPresenter extends GetxController {
  final source = MenuSource().obs;

  void add(BuildContext context) {
    showDialog(context: context, builder: (context) => MenuFormView());
  }
}
