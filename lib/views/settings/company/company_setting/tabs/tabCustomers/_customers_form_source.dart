import 'dart:typed_data';

import 'package:boilerplate/presenters/settings/stbptype/stbptypeactivitycategory_presenter.dart';
import 'package:boilerplate/services/settings/customfield_service.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../../../../../constants/base_text.dart';
import '../../../../../../helpers/function.dart';
import '../../../../../../models/address_model.dart';
import '../../../../../../models/session_model.dart';
import '../../../../../../presenters/masters/customer_presenter.dart';
import '../../../../../../presenters/navigation_presenter.dart';
import '../../../../../../styles/color_palattes.dart';
import '../../../../../../utils/select_api.dart';
import '../../../../../../utils/session_manager.dart';
import '../../../../../../utils/validators.dart';
import '../../../../../../widgets/form_group.dart';
import '../../../../../../widgets/input/custom_input.dart';
import '../../../../../../widgets/map/_map_source.dart';
import '../../../../../../widgets/map/map.dart';
import '../../../../../../widgets/selectbox/custom_selectbox.dart';
import '../../../../../ventes/prospect/customer/_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final _cpresenter = Get.find<CustomerPresenter>();
final map = Get.put(MapSource());

class CustomersFormController extends GetxController {
  bool isProcessing = false;
  var isnGetLatLong = true.obs;
  var isRegistered = false.obs;

  var id = 0.obs;

  var pro = false.obs;

  var format = ''.obs;

  var imgname = ''.obs;
  var image = Uint8List(1).obs;
  var isImage = false.obs;

  final createdby = Rx<String>('');
  final createddate = Rx<String>('');
  final updatedby = Rx<String>('');
  final updateddate = Rx<String>('');
  final isactive = Rx<bool>(true);

  reset() {
    map.reset();
    isProcessing = false;
    isnGetLatLong.value = false;
    isRegistered.value = false;

    format.value = '';

    imgname.value = '';
    image.value = Uint8List(1);
    isImage.value = false;

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;

    inputPrefix.text = '';
    inputName.text = '';
    inputPhone.text = '';
    inputAddress.text = '';
    inputReferal.text = '';
    inputProvince.text = '';
    inputCity.text = '';
    inputSubdistrict.text = '';
    inputVillage.text = '';
    inputPostal.text = '';

    selectCustomer.clear();
    selectType.clear();
    // selectStatus.clear();
  }

  TextEditingController inputPrefix = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputCode = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputReferal = TextEditingController();

  TextEditingController inputProvince = TextEditingController();
  TextEditingController inputCity = TextEditingController();
  TextEditingController inputSubdistrict = TextEditingController();
  TextEditingController inputVillage = TextEditingController();
  TextEditingController inputPostal = TextEditingController();
  TextEditingController inputAddress = TextEditingController();

  BsSelectBoxController selectCustomer = BsSelectBoxController();
  BsSelectBoxController selectType = BsSelectBoxController();

  // BsSelectBoxController selectStatus = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    var json;
    SessionModel session = await SessionManager.current();
    if (isRegistered.value) {
      print("is registered");
      String name = await _cpresenter
          .cstm(parseInt(selectCustomer.getSelectedAsString()));
      print(name);
      imgname.value = name;
      print(imgname.value);
      json = {
        'isregistered': isRegistered.value,
        'sbcbpid': box.read('mybpid'),
        'cstmid': selectCustomer.getSelectedAsString(),
        'sbccstmstatusid': pro.value ? 'Pro' : 'Cust',
        'sbccstmpic': isImage.value
            ? MultipartFile(image.value, filename: imgname.value)
            : null,
        'createdby': session.userid,
        'updatedby': session.userid,
      };
      print(json);
    } else {
      List ids = await _cpresenter.getId({
        'village': inputVillage.text,
        'subdistrict': inputSubdistrict.text,
        'city': inputCity.text,
        'province': inputProvince.text
      });
      AddressModel id = AddressModel.fromJson(ids.first);
      json = {
        'isregistered': isRegistered.value,
        'cstmprefix': inputPrefix.text,
        'cstmname': inputName.text,
        'cstmcode': inputCode.text,
        'cstmphone': inputPhone.text,
        'cstmaddress': inputAddress.text,
        'cstmtypeid': selectType.getSelectedAsString(),
        'cstmprovinceid':
            id.villagesubdistrict!.subdistrictcity!.cityprov!.provid.toString(),
        'cstmcityid': id.villagesubdistrict!.subdistrictcity!.cityid.toString(),
        'cstmsubdistrictid': id.villagesubdistrict!.subdistrictid.toString(),
        'cstmuvid': id.villageid.toString(),
        'cstmpostalcode': inputPostal.text,
        'cstmlatitude': map.latitude.value,
        'cstmlongitude': map.longitude.value,
        'referalcode': inputReferal.text,
        'sbccstmpic': isImage.value
            ? MultipartFile(image.value, filename: inputName.text)
            : null,
        'sbcbpid': box.read('mybpid'),
        'sbccstmstatusid': pro.value ? 'Pro' : 'Cust',
        'createdby': session.userid,
        'updatedby': session.userid,
      };
    }
    return json;
  }
}

class CustomersFormSource {
  final CustomersFormController controller;
  final map = Get.put(MapSource());
  final CustomerPresenter presenter = Get.find<CustomerPresenter>();

  CustomersFormSource(this.controller);

  // Widget selectBpCustomerTypes() {
  //   return FormGroup(
  //     label: Obx(() => Text(PCustomerText.labelBpCustomerType,
  //         style: TextStyle(
  //             color:
  //                 _navigation.darkTheme.value ? Colors.white : Colors.black))),
  //     child: CustomSelectBox(
  //       searchable: false,
  //       disabled: controller.isProcessing,
  //       controller: controller.selectStatus,
  //       hintText:
  //           BaseText.hiintSelect(field: PCustomerText.labelBpCustomerType),
  //       serverSide: (params) => selectApiBpCustomerStatus(params),
  //       validators: [
  //         Validators.selectRequired(PCustomerText.labelBpCustomerType),
  //       ],
  //     ),
  //   );
  // }

  Widget inputPrefix() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelPrefix,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isProcessing,
        controller: controller.inputPrefix,
        hintText: BaseText.hintText(field: PCustomerText.labelPrefix),
        validators: [
          Validators.maxLength(PCustomerText.labelPrefix, 100),
        ],
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isProcessing,
        controller: controller.inputName,
        hintText: BaseText.hintText(field: PCustomerText.labelName),
        validators: [
          Validators.inputRequired(PCustomerText.labelName),
          Validators.maxLength(PCustomerText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputCode() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelCode,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isProcessing,
        controller: controller.inputCode,
        hintText: BaseText.hintText(field: PCustomerText.labelCode),
        validators: [
          Validators.inputRequired(PCustomerText.labelCode),
          Validators.maxLength(PCustomerText.labelCode, 100),
        ],
      ),
    );
  }

  Widget inputPhone() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelPhone,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isProcessing,
        controller: controller.inputPhone,
        keyboardType: TextInputType.number,
        hintText: BaseText.hintText(field: PCustomerText.labelPhone),
        validators: [
          Validators.maxLength(PCustomerText.labelPhone, 20),
        ],
      ),
    );
  }

  Widget inputAddress() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelAddress,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Obx(() => CustomInput(
            disabled: controller.isnGetLatLong.value,
            controller: controller.inputAddress,
            hintText: BaseText.hintText(field: PCustomerText.labelAddress),
            validators: [],
            maxLines: 5,
            minLines: 1,
          )),
    );
  }

  Widget selectTypes(context) {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        disabled: controller.isProcessing,
        controller: controller.selectType,
        hintText: BaseText.hiintSelect(field: PCustomerText.labelType),
        serverSide: (params) => selectApiCustomerType(params),
        validators: [Validators.selectRequired(PCustomerText.labelType)],
        onChange: (value) async {
          if (value.getValueAsString() == 'add') {
            SessionModel session = await SessionManager.current();
            final presenter = Get.find<StBpTypeActivityCategoryPresenter>();
            presenter.save(context, {
              'sbtbpid': box.read('mybpid'),
              'sbtname': value.getOtherValue()['master'],
              'sbttypemasterid': value.getOtherValue()['masterid'],
              'sbttypename': value.getOtherValue()['name'],
              'createdby': session.userid,
              'updatedby': session.userid,
              'isactive': true,
            });
            controller.selectType.clear();
          }
        },
      ),
    );
  }

  Widget inputReferal() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelReferal,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isProcessing,
        controller: controller.inputReferal,
        hintText: BaseText.hintText(field: PCustomerText.labelReferal),
        validators: [
          Validators.maxLength(PCustomerText.labelPhone, 255),
        ],
      ),
    );
  }

  Widget btnImage() {
    return FormGroup(
      child: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (controller.isImage.value)
                  Image.memory(controller.image.value),
                BsButton(
                  margin: EdgeInsets.only(top: 10),
                  onPressed: () async {
                    Uint8List? fromPicker =
                        await ImagePickerWeb.getImageAsBytes();
                    if (fromPicker != null) {
                      controller.image.value = fromPicker;
                      controller.isImage.value = true;
                    }
                  },
                  label: Text(
                    PCustomerText.labelImage,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget btnMap(context) {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelButton,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Tooltip(
        message: map.latitudelongitude.isNotEmpty
            ? map.latitudelongitude.value
                .split(',')
                .map((text) => text)
                .toString()
            : "",
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
              return Text(
                "${map.latitudelongitude.value.split(',').first}...",
              );
            } else {
              return Text("Choose location");
            }
          }),
        ),
      ),
    );
  }

  Widget inputProvince() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelProvince,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isnGetLatLong.value,
        controller: controller.inputProvince,
        hintText: BaseText.hintText(field: PCustomerText.labelProvince),
      ),
    );
  }

  Widget inputCity() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelCity,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isnGetLatLong.value,
        controller: controller.inputCity,
        hintText: BaseText.hintText(field: PCustomerText.labelCity),
      ),
    );
  }

  Widget inputSubdistrict() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelSubdistrict,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isnGetLatLong.value,
        controller: controller.inputSubdistrict,
        hintText: BaseText.hintText(field: PCustomerText.labelSubdistrict),
      ),
    );
  }

  Widget inputVillage() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelVillage,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isnGetLatLong.value,
        controller: controller.inputVillage,
        hintText: BaseText.hintText(field: PCustomerText.labelVillage),
      ),
    );
  }

  Widget inputPostal() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelPostal,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: controller.isnGetLatLong.value,
        controller: controller.inputPostal,
        hintText: BaseText.hintText(field: PCustomerText.labelPostal),
      ),
    );
  }

  Widget selectCustomer() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelCustomer,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: controller.isProcessing,
        controller: controller.selectCustomer,
        hintText: BaseText.hiintSelect(field: PCustomerText.labelCustomer),
        serverSide: (params) => selectApiCustomer(params),
        validators: [
          Validators.selectRequired(PCustomerText.labelCustomer),
        ],
      ),
    );
  }

  Widget checkBox() {
    return BsRow(
      children: [
        BsCol(
          sizes: ColScreen(sm: Col.col_3),
          child: Obx(() => Row(
                children: [
                  Text(PCustomerText.labelRegistered,
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold)),
                  Checkbox(
                    value: controller.isRegistered.value,
                    onChanged: (value) => controller.isRegistered.toggle(),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
