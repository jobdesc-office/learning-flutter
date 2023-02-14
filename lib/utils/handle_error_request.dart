import 'package:get/get.dart';

class HandleErrorRequest {
  void onErrorRequest(Response response, {context}) {
    if (response.statusCode == 401) {}
  }
}
