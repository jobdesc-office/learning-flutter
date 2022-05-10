import 'package:get/get.dart';

import '../../contracts/default/home_view_contract.dart';
import '../../services/default/home_service.dart';
import '../../utils/custom_get_controller.dart';

class HomePresenter extends CustomGetXController {
  final _homeService = Get.find<HomeService>();

  late HomeViewContract _homeContract;
  set homeContract(HomeViewContract homeContract) {
    _homeContract = homeContract;
  }

  Future index() async {
    Response response = await _homeService.index();
    if (response.statusCode == 200)
      _homeContract.onSuccess(response);
    else
      _homeContract.onError(response);
  }
}
