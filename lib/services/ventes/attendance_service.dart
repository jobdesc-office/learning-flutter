import 'package:boilerplate/config.dart';
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

  Future<Response> recap({start, end, startdate, enddate, bpid, role}) {
    return get('$api/recap', query: {
      'start': [start.toString()],
      'end': [end.toString()],
      'startdate': [startdate.toString()],
      'enddate': [enddate.toString()],
      'bpid': [bpid.toString()],
      'role': [role.toString()],
    });
  }

  Future<Response> recapDetail({attid}) {
    return get('$api/recapdetail/$attid');
  }

  String exportRecap(String start, String end, String startdate, String enddate,
      String bpid, String role, String token) {
    return '${Config.api}/$api/exportrecap?token=$token&start=$start&end=$end&startdate=$startdate&enddate=$enddate&bpid=$bpid&role=$role';
  }

  Future<Response> removeExcel({filename}) {
    return get('$api/removerecap', query: {
      'filename': [filename.toString()],
    });
  }
}
