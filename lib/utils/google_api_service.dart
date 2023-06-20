import 'package:boilerplate/config.dart';
import 'package:get/get.dart';

class GoogleAPIService extends GetConnect {
  Future<Response> getHolidays() {
    return get(
        'https://www.googleapis.com/calendar/v3/calendars/en.indonesian%23holiday%40group.v.calendar.google.com/events?key=' +
            Config.googleApi);
  }
}
