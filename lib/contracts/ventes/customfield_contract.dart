import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CustomFieldContract {
  void onLoadSuccess(BuildContext context, Response response);

  void onErrorRequest(Response response);
}
