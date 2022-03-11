import 'package:get/state_manager.dart';

class CustomGetXController {
  final isLoading = false.obs;

  void setLoading(bool loading) {
    isLoading.value = loading;
  }
}
