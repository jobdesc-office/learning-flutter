import 'package:boilerplate/models/masters/type_model.dart';
import 'package:boilerplate/models/security/menu_model.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/config_types.dart';
import '../models/masters/businesspartner_model.dart';
import '../models/masters/city_model.dart';
import '../models/masters/country_model.dart';
import '../models/masters/customer_model.dart';
import '../models/masters/product_model.dart';
import '../models/masters/province_model.dart';
import '../models/masters/user_model.dart';
import '../services/masters/city_service.dart';
import '../services/masters/country_service.dart';
import '../services/masters/customer_service.dart';
import '../services/masters/product_service.dart';
import '../services/masters/province_service.dart';
import '../services/masters/type_service.dart';
import '../services/masters/typechildren_service.dart';
import '../services/masters/user_service.dart';
import '../services/security/menu_service.dart';
import 'connect_internet_api.dart';

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

Future<BsSelectBoxResponse> selectApiCustomerType(
    Map<String, String> params) async {
  final typeService = Get.put(TypeService());
  Response response = await typeService.byCode('cstmtype');
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

Future<BsSelectBoxResponse> selectApiProspectStatus(
    Map<String, String> params) async {
  final typeService = Get.put(TypeService());
  Response response = await typeService.byCode('prstatus');
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

Future<BsSelectBoxResponse> selectApiUser(Map<String, String> params) async {
  final userService = Get.find<UserService>();
  Response response = await userService.all();
  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => UserModel.fromJson(data).userid,
        renderText: (data) => Text(UserModel.fromJson(data).userfullname),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}

Future<BsSelectBoxResponse> selectApiProspectOwner(
    Map<String, String> params) async {
  final userService = Get.find<UserService>();
  Response response = await userService.all();
  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => UserModel.fromJson(data).userid,
        renderText: (data) => Text(UserModel.fromJson(data).userfullname),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}

Future<BsSelectBoxResponse> selectApiCustomer(
    Map<String, String> params) async {
  final customerService = Get.find<CustomerService>();
  Response response = await customerService.select(params);
  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => CustomerModel.fromJson(data).cstmid,
        renderText: (data) => Text(CustomerModel.fromJson(data).cstmname),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}

Future<BsSelectBoxResponse> selectApiProduct(Map<String, String> params) async {
  final productService = Get.find<ProductService>();
  Response response = await productService.select(params);
  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => ProductModel.fromJson(data).productid,
        renderText: (data) => Text(ProductModel.fromJson(data).productname),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}

Future<BsSelectBoxResponse> selectApiProductWithBp(
    Map<String, String> params, String id) async {
  final productService = Get.find<ProductService>();
  Response response = await productService.selectWithBp(params, id);
  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => ProductModel.fromJson(data).productid,
        renderText: (data) => Text(ProductModel.fromJson(data).productname),
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
  Response response = await typeChildrenService.parent(params);
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

Future<BsSelectBoxResponse> selectApiTypeChildren(
    Map<String, String> params) async {
  final typeService = Get.put(TypeService());
  Response response = await typeService.byCode('schedule');
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

Future<BsSelectBoxResponse> selectTimeZone(Map<String, String> params) async {
  Response response = await ConnectInternetAPI().timeZone();
  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => data,
        renderText: (data) => Text(data),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}

Future<BsSelectBoxResponse> selectApiTaxTypes(
    Map<String, String> params) async {
  final typeService = Get.find<TypeService>();
  Response response = await typeService.byCode(ConfigType.taxType);

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

Future<BsSelectBoxResponse> selectApiProspectTypes(
    Map<String, String> params) async {
  final typeService = Get.find<TypeService>();
  Response response = await typeService.byCode(ConfigType.prospectType);

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

Future<BsSelectBoxResponse> selectCountries(Map<String, String> params) async {
  final countryService = Get.find<CountryService>();
  Response response = await countryService.all();

  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => CountryModel.fromJson(data).countryid,
        renderText: (data) => Text(CountryModel.fromJson(data).countryname),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}

Future<BsSelectBoxResponse> selectProvinces(Map<String, String> params) async {
  final provinceService = Get.find<ProvinceService>();
  Response response = await provinceService.all();

  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => ProvinceModel.fromJson(data).provid,
        renderText: (data) => Text(ProvinceModel.fromJson(data).provname),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}

Future<BsSelectBoxResponse> selectCities(Map<String, String> params) async {
  final cityService = Get.find<CityService>();
  Response response = await cityService.all();

  if (response.isOk) {
    if (response.statusCode == 200) {
      return BsSelectBoxResponse.createFromJson(
        response.body,
        value: (data) => CityModel.fromJson(data).cityid,
        renderText: (data) => Text(CityModel.fromJson(data).cityname),
      );
    }
  }

  return BsSelectBoxResponse(options: []);
}
