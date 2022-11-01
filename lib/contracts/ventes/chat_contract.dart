import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ChatContract {
  void onLoadUsers(BuildContext context, Response response);

  void onLoadChats(BuildContext context, Response response);
}
