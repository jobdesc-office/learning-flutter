import 'package:get/get.dart';

abstract class HomeViewContract {
  void onSuccess(Response response);
  void onError(dynamic message);
}
