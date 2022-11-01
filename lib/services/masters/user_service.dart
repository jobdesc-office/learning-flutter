import 'package:get/get.dart';

import '../../models/session_model.dart';
import '../../utils/api_connect_provider.dart';
import '../../utils/session_manager.dart';

class UserService extends ApiConnectProvider {
  String get api => 'user';

  Future<Response> selectsamebp(Map<String, dynamic> params, int id) {
    return get('$api/select/$id', query: params);
  }

  Future<Response> datatablesbp(Map<String, dynamic> params, int id) {
    return post('$api/datatables/$id', params);
  }

  Future<Response> session(int id) {
    return get('$api/session');
  }

  Future<Response> reset(int id) {
    return get('$api/reset/$id');
  }

  Future<Response> samebp() {
    return get('$api/samebp/${box.read('mybpid')}');
  }

  Future<Response> setSocketId(String? socketid) async {
    SessionModel session = await SessionManager.current();
    return await update(session.userid!, {
      'usersocketid': socketid,
    });
  }
}
