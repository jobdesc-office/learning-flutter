import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class IndexViewContract {
  void onLoadDatatables(BuildContext context, Response response);

  void onCreateSuccess(Response response, {BuildContext? context});

  void onEditSuccess(Response response, {BuildContext? context});

  void onDeleteSuccess(Response response, {BuildContext? context});

  void onErrorRequest(Response response);
}
