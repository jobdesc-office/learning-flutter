import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CustomFieldContract {
  void onLoadCustomFieldSuccess(BuildContext context, Response response);

  void onErrorCustomFieldRequest(Response response);
}
