import 'package:get/get.dart';

class UserDetailModel extends GetxController{
  var role = 1.obs;
  var rightLeft = false.obs;

  increase() => role++;

  decrease() => role--;
  
}