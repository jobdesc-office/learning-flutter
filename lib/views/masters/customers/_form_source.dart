import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/masters/customer_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/input/custom_input_number.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/map/map.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final _presenter = Get.find<CustomerPresenter>();

class CustomerSource extends GetxController {
  bool isProcessing = false;
  var isnGetLatLong = true.obs;

  TextEditingController inputPrefix = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputAddress = TextEditingController();
  TextEditingController inputReferal = TextEditingController();
  TextEditingController inputProvince = TextEditingController();
  TextEditingController inputCity = TextEditingController();
  TextEditingController inputSubdistrict = TextEditingController();
  TextEditingController inputPostal = TextEditingController();

  BsSelectBoxController selectType = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    // _presenter.getProvinceId({'name': inputProvince.text});
    // _presenter.getCityId({'name': inputCity.text});
    // _presenter.getSubdistrictId({'name': inputSubdistrict.text});
    int provid = await _presenter.getProvinceId({'name': inputProvince.text});
    int cityid = await _presenter.getCityId({'name': inputCity.text});
    int subdistrictid =
        await _presenter.getSubdistrictId({'name': inputSubdistrict.text});
    SessionModel session = await SessionManager.current();
    final map = Get.put(mapSource());
    return {
      'cstmprefix': inputPrefix.text,
      'cstmname': inputName.text,
      'cstmphone': inputPhone.text,
      'cstmaddress': inputAddress.text,
      'cstmtypeid': selectType.getSelectedAsString(),
      'cstmprovinceid': provid.toString(),
      'cstmcityid': cityid.toString(),
      'cstmsubdistrictid': subdistrictid.toString(),
      'cstmuvid': null,
      'cstmpostalcode': inputPostal.text,
      'cstmlatitude': map.latitude.value,
      'cstmlongitude': map.longitude.value,
      'referalcode': inputReferal.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class CustomerForm {
  final CustomerSource source;
  final map = Get.put(mapSource());
  final CustomerPresenter presenter = Get.find<CustomerPresenter>();

  CustomerForm(this.source);

  Widget inputPrefix() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelPrefix,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputPrefix,
        hintText: BaseText.hintText(field: CustomerText.labelPrefix),
        validators: [
          Validators.maxLength(CustomerText.labelPrefix, 100),
        ],
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: CustomerText.labelName),
        validators: [
          Validators.inputRequired(CustomerText.labelName),
          Validators.maxLength(CustomerText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputPhone() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelPhone,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputPhone,
        hintText: BaseText.hintText(field: CustomerText.labelPhone),
        validators: [
          Validators.maxLength(CustomerText.labelPhone, 20),
        ],
      ),
    );
  }

  Widget inputAddress() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelAddress,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Obx(() => CustomInput(
            disabled: source.isnGetLatLong.value,
            controller: source.inputAddress,
            hintText: BaseText.hintText(field: CustomerText.labelAddress),
            validators: [],
            maxLines: 5,
            minLines: 1,
          )),
    );
  }

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: CustomerText.labelType),
        serverSide: (params) => selectApiCustomerType(params),
      ),
    );
  }

  Widget inputReferal() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelReferal,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputReferal,
        hintText: BaseText.hintText(field: CustomerText.labelReferal),
        validators: [],
      ),
    );
  }

  Widget btnMap(context) {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelButton,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: BsButton(
        style: BsButtonStyle(
            color: Color.fromARGB(255, 165, 165, 165),
            backgroundColor: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderColor: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        width: MediaQuery.of(context).size.width,
        onPressed: () => Get.to(GoogleMapsPage()),
        label: Obx(() {
          if (map.latitudelongitude.isNotEmpty) {
            presenter.address(map.latitudelongitude.value);
            return Text(map.latitudelongitude.isEmpty
                ? "Choose the Place"
                : map.latitudelongitude.value);
          } else {
            return Text(map.latitudelongitude.isEmpty
                ? "Choose the Place"
                : map.latitudelongitude.value);
          }
        }),
      ),
    );
  }

  Widget inputProvince() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelProvince,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isnGetLatLong.value,
        controller: source.inputProvince,
        hintText: BaseText.hintText(field: CustomerText.labelProvince),
        validators: [],
      ),
    );
  }

  Widget inputCity() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelCity,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isnGetLatLong.value,
        controller: source.inputCity,
        hintText: BaseText.hintText(field: CustomerText.labelCity),
        validators: [],
      ),
    );
  }

  Widget inputSubdistrict() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelSubdistrict,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isnGetLatLong.value,
        controller: source.inputSubdistrict,
        hintText: BaseText.hintText(field: CustomerText.labelSubdistrict),
        validators: [],
      ),
    );
  }

  Widget inputPostal() {
    return FormGroup(
      label: Obx(() => Text(CustomerText.labelPostal,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isnGetLatLong.value,
        controller: source.inputPostal,
        hintText: BaseText.hintText(field: CustomerText.labelPostal),
        validators: [],
      ),
    );
  }
}
