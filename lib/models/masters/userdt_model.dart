import 'package:get/get.dart';

class UserDetailModel extends GetxController{
  var role = 1.obs;
  var partner = 1.obs;

  increase() => role++;

  decrease() => role--;

  up() => partner++;

  down() => partner--;
  
}