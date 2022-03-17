import 'package:get/get.dart';

abstract class GuardContract {
  void onCheckSuccess({bool isOk = true, bool redirect = true});

  void onCheckFailed();

  void onCheckTimeout();

  void onCheckInternalError();
}
