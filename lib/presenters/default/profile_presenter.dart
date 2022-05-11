import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../contracts/default/profile_view_contract.dart';
import '../../services/default/profile_service.dart';
import '../../utils/custom_get_controller.dart';

class ProfilePresenter extends CustomGetXController {
  final _profileService = Get.find<ProfileService>();
  final box = GetStorage();

  late ProfileViewContract _profileContract;
  set profileContract(ProfileViewContract profileContract) {
    _profileContract = profileContract;
  }

  Future index() async {
    Response response = await _profileService.profile(box.read('id'));
    if (response.statusCode == 200)
      _profileContract.onSuccess(response);
    else
      _profileContract.onError(response);
  }
}
