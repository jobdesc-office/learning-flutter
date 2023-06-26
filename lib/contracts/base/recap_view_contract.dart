import 'package:get/get.dart';

abstract class RecapViewContract {
  void onLoadDatatables(Response response);

  void onDetailFetch(Response response);

  void onLoadHolidays(Response response);

  void onErrorRequest(Response response, {context});
}
