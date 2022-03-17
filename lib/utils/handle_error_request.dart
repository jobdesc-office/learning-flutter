import 'package:get/get.dart';

class HandleErrorRequest {
  void onErrorRequest(Response response) {
    if (response.statusCode == 401) {}
  }
}
