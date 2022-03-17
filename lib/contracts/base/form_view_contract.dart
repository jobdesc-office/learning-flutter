import 'package:get/get.dart';

abstract class FormViewContract {
  void onRequestSuccess(Response response);
  void onErrorRequest(dynamic message);
}
