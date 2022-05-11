import 'package:get/get.dart';

abstract class ProfileViewContract {
  void onSuccess(Response response);
  void onError(dynamic message);
}
