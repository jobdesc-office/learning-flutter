import 'package:get/get.dart';

class CustomGetXController {
  final isProcessing = false.obs;

  void setProcessing(bool processing) {
    isProcessing.value = processing;
  }
}
