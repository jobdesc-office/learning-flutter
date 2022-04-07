import 'package:boilerplate/models/masters/type_model.dart';
import 'package:boilerplate/models/security/menu_model.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/masters/businesspartner_model.dart';
import '../services/masters/type_service.dart';
import '../services/masters/typechildren_service.dart';
import '../services/masters/user_service.dart';
import '../services/security/menu_service.dart';

Future<BsSelectBoxResponse> selectApiMenu(Map<String, String> params) async {
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

Future<BsSelectBoxResponse> selectApiRole(Map<String, String> params) async {
  final userService = Get.find<UserService>();
  Response response = await userService.select(params);
  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => TypeModel.fromJson(data).typeid,
        renderText: (data) => Text(TypeModel.fromJson(data).typename),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}

Future<BsSelectBoxResponse> selectApiPartner(Map<String, String> params) async {
  final userService = Get.find<UserService>();
  Response response = await userService.select2(params);
  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => BusinessPartnerModel.fromJson(data).bpid,
        renderText: (data) => Text(BusinessPartnerModel.fromJson(data).bpname),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}

Future<BsSelectBoxResponse> selectApiTypeParents(
    Map<String, String> params) async {
  final typeChildrenService = Get.find<TypeChildrenService>();
  Response response = await typeChildrenService.parent();
  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => TypeModel.fromJson(data).typeid,
        renderText: (data) => Text(TypeModel.fromJson(data).typename),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}
