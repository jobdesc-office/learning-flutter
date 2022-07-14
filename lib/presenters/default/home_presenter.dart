import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../contracts/default/home_view_contract.dart';
import '../../services/default/home_service.dart';
import '../../utils/custom_get_controller.dart';

class HomePresenter extends CustomGetXController {
  final _homeService = Get.find<HomeService>();
  final box = GetStorage();

  late HomeViewContract _homeContract;
  set homeContract(HomeViewContract homeContract) {
    _homeContract = homeContract;
  }

  Future index() async {
    Response response = await _homeService.index(box.read('id'));
    if (response.statusCode == 200)
      _homeContract.onSuccess(response);
    else
      _homeContract.onError(response);
  }
}
