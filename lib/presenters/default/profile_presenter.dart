import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/default/profile_service.dart';
import '../../utils/custom_get_controller.dart';

class ProfilePresenter extends CustomGetXController {
  final _profileService = Get.find<ProfileService>();
  final box = GetStorage();

  Future index() async {
    Response response = await _profileService.profile(box.read('id'));

    // final List<ProfileModel> data = [];

    // for (var dt in response.body) {
    //   ProfileModel scheduleData = ProfileModel(
    //     scheid: dt['scheid'],
    //     schenm: dt['schenm'],
    //     schestartdate: dt['schestartdate'],
    //     schestarttime: dt['schestarttime'],
    //   );
    //   data.add(scheduleData);
    // }
    return jsonDecode(response.body);
  }
}
