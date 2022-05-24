import 'package:get/get.dart';

import '../../models/masters/maps_model.dart';
import '../../utils/connect_internet_api.dart';
import '../../utils/custom_get_controller.dart';
import '../../contracts/master/customerAddress_contract.dart';

class MapPresenter extends CustomGetXController {
  late CustomerAddressContract _loadAddressContract;
  set mapAddresContract(CustomerAddressContract loadAddressContract) {
    _loadAddressContract = loadAddressContract;
  }

  Future address(String latitudelongitude) async {
    Response response = await ConnectInternetAPI().address(latitudelongitude);

    MapsLoc address = MapsLoc.fromJson(response.body);
    List<AddressComponents>? addresses =
        address.adresses?.first.addressComponents;
    String country = addresses!
            .firstWhere((element) => element.types!.contains('country'))
            .shortName ??
        "";
    return country;
  }
}
