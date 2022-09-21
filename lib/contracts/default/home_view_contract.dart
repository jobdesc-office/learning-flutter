import 'package:get/get.dart';

abstract class HomeViewContract {
  void onSuccessDspbycust(Response response);
  void onSuccessDspbystage(Response response);
  void onSuccessDspbystatus(Response response);
  void onSuccessDspbycustlabel(Response response);
  void onSuccessDspbyowner(Response response);
  void onSuccessDspbybp(Response response);
  void onError(dynamic message);
}
