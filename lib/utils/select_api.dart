import 'package:boilerplate/models/security/menu_model.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/security/menu_service.dart';

Future<BsSelectBoxResponse> selectMenu(Map<String, String> params) async {
  final menuService = Get.find<MenuService>();
  Response response = await menuService.select(params);

  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => MenuModel.fromJson(data).menuid,
        renderText: (data) => Text(MenuModel.fromJson(data).menunm),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}
