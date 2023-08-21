import 'dart:convert';

import 'package:get/get.dart';

import '../../models/masters/maps_model.dart';
import '../../utils/connect_internet_api.dart';
import '../../utils/custom_get_controller.dart';

class MapPresenter extends CustomGetXController {
  Future address(String latitudelongitude) async {
    Response response = await ConnectInternetAPI().address(latitudelongitude);

    MapsLoc address = MapsLoc.fromJson(jsonDecode(response.body));
    List<AddressComponents>? addresses =
        address.adresses?.first.addressComponents;
    String country = addresses!
            .firstWhere((element) => element.types!.contains('country'))
            .shortName ??
        "";
    return country;
  }
}
