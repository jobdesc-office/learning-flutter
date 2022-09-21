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

  Future byCust(
      {Map<String, dynamic> params = const {}, String order = 'asc'}) async {
    Response response = await _homeService.byCust(params: params, order: order);
    if (response.statusCode == 200)
      _homeContract.onSuccessDspbycust(response);
    else
      _homeContract.onError(response);
  }

  Future byStatus({Map<String, dynamic> params = const {}}) async {
    Response response = await _homeService.byStatus(params: params);
    if (response.statusCode == 200)
      _homeContract.onSuccessDspbystatus(response);
    else
      _homeContract.onError(response);
  }
}
