import 'package:get/get.dart';

import '../../contracts/default/information_view_contract.dart';
import '../../services/default/info_service.dart';
import '../../utils/custom_get_controller.dart';

class InformationPresenter extends CustomGetXController {
  final _infoService = Get.put(InfoService());

  late InformationViewContract _infoContract;
  set infoContract(InformationViewContract infoContract) {
    _infoContract = infoContract;
  }

  Future getInfo(String infoname) async {
    Response response = await _infoService.getInfo(infoname);
    if (response.statusCode == 200) _infoContract.onSuccess(response);
  }
}
