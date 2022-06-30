import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProspectCustomFieldContract {
  void onFetchCustomFieldSuccess(BuildContext context, Response response);

  void onFetchCustomFieldErrorRequest(Response response);
}
