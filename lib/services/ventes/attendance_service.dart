import 'package:boilerplate/presenters/auth_presenter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/api_connect_provider.dart';

class AttendanceService extends ApiConnectProvider {
  String get api => 'attendance';
  final box = GetStorage();

  final authPresenter = Get.find<AuthPresenter>();

  Future<Response> bpid(int id) {
    return get('$api/bp/$id');
  }

  Future<Response> selectbp(Map<String, dynamic> params) {
    return get('$api/select/${box.read('mybpid')}', query: params);
  }

  Future<Response> datatablesbp(Map<String, dynamic> params,
      {start, end, userid}) {
    return post('$api/datatables/${box.read('mybpid')}', params, query: {
      'startdate': start,
      'enddate': end,
      'userid': userid,
    });
  }

  Future<Response> calendar({start, end, startdate, enddate}) {
    return get('$api/calendar', query: {
      'start': [start.toString()],
      'end': [end.toString()],
      'startdate': [startdate.toString()],
      'enddate': [enddate.toString()],
    });
  }

  Future<Response> exportCalendar({start, end, startdate, enddate}) {
    return get('$api/exportcalendar', query: {
      'start': [start.toString()],
      'end': [end.toString()],
      'startdate': [startdate.toString()],
      'enddate': [enddate.toString()],
    });
  }

  Future<Response> removeExcel({filename}) {
    return get('$api/removecalendar', query: {
      'filename': [filename.toString()],
    });
  }
}
