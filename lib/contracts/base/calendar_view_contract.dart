import 'package:get/get.dart';

abstract class CalendarViewContract {
  void onLoadDatatables(Response response);

  void onErrorRequest(Response response, {context});
}
