import 'package:get/get.dart';

class NavigationPresenter extends GetxController {
  final isCollapse = false.obs;

  void toggleCollapse() => isCollapse.value = !isCollapse.value;
}
