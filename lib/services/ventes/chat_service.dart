import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ChatService extends ApiConnectProvider {
  String get api => 'chat';

  Future<Response> conversation(int receiverid) {
    return get('$api/conversation', query: {
      'user1': '${box.read('id')}',
      'user2': '$receiverid',
    });
  }
}
