import 'dart:typed_data';

import 'package:boilerplate/services/ventes/customfield_service.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../../../constants/base_text.dart';
import '../../../../helpers/function.dart';
import '../../../../models/address_model.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/masters/customer_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/map/_map_source.dart';
import '../../../../widgets/map/map.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final _cpresenter = Get.find<CustomerPresenter>();

class PCustomerSource extends GetxController {
  bool isProcessing = false;
  var isnGetLatLong = true.obs;
  var isRegistered = false.obs;

  var imgname = ''.obs;
  var image = Uint8List(1).obs;
  var isImage = false.obs;

  TextEditingController inputPrefix = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputAddress = TextEditingController();
  TextEditingController inputReferal = TextEditingController();
  TextEditingController inputProvince = TextEditingController();
  TextEditingController inputCity = TextEditingController();
  TextEditingController inputSubdistrict = TextEditingController();
  TextEditingController inputVillage = TextEditingController();
  TextEditingController inputPostal = TextEditingController();

  TextEditingController inputContactName = TextEditingController();
  TextEditingController inputValue = TextEditingController();

  BsSelectBoxController selectCustomer = BsSelectBoxController();
  BsSelectBoxController selectType = BsSelectBoxController();

  BsSelectBoxController selectContactType = BsSelectBoxController();

  BsSelectBoxController selectStatus = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    var json;
    SessionModel session = await SessionManager.current();
    final map = Get.put(MapSource());
    if (isRegistered.value) {
      String name = await _cpresenter
          .cstm(parseInt(selectCustomer.getSelectedAsString()));
      imgname.value = name;
      json = {
        'isregistered': isRegistered.value,
        'contactcustomerid': selectCustomer.getSelectedAsString(),
        'contactname': inputContactName.text,
        'contacttypeid': selectContactType.getSelectedAsString(),
        'contactvalueid': inputValue.text,
        'sbcbpid': authPresenter.bpActiveId.value,
        'cstmid': selectCustomer.getSelectedAsString(),
        'sbccstmstatusid': selectStatus.getSelectedAsString(),
        'sbccstmpic': isImage.value
            ? MultipartFile(image.value, filename: imgname.value)
            : null,
        'createdby': session.userid,
        'updatedby': session.userid,
      };
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
        'contactname': inputContactName.text,
        'contacttypeid': selectContactType.getSelectedAsString(),
        'contactvalueid': inputValue.text,
        'sbccstmpic': isImage.value
            ? MultipartFile(image.value, filename: inputName.text)
            : null,
        'sbcbpid': authPresenter.bpActiveId.value,
        'sbccstmstatusid': selectStatus.getSelectedAsString(),
        'createdby': session.userid,
        'updatedby': session.userid,
      };
    }
    return json;
  }
}

class PCustomerForm {
  final PCustomerSource source;
  final map = Get.put(MapSource());
  final CustomerPresenter presenter = Get.find<CustomerPresenter>();

  PCustomerForm(this.source);

  Widget inputPrefix() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelPrefix,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputPrefix,
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
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: PCustomerText.labelName),
        validators: [
          Validators.inputRequired(PCustomerText.labelName),
          Validators.maxLength(PCustomerText.labelName, 100),
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
        disabled: source.isProcessing,
        controller: source.inputPhone,
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
            disabled: source.isnGetLatLong.value,
            controller: source.inputAddress,
            hintText: BaseText.hintText(field: PCustomerText.labelAddress),
            validators: [],
            maxLines: 5,
            minLines: 1,
          )),
    );
  }

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: PCustomerText.labelType),
        serverSide: (params) => selectApiCustomerType(params),
        validators: [Validators.selectRequired(PCustomerText.labelType)],
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
        disabled: source.isProcessing,
        controller: source.inputReferal,
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
                if (source.isImage.value) Image.memory(source.image.value),
                BsButton(
                  margin: EdgeInsets.only(top: 10),
                  onPressed: () async {
                    Uint8List? fromPicker =
                        await ImagePickerWeb.getImageAsBytes();
                    if (fromPicker != null) {
                      source.image.value = fromPicker;
                      source.isImage.value = true;
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
      label: Obx(() => Text(PCustomerText.labelProvince,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isnGetLatLong.value,
        controller: source.inputProvince,
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
        disabled: source.isnGetLatLong.value,
        controller: source.inputCity,
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
        disabled: source.isnGetLatLong.value,
        controller: source.inputSubdistrict,
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
        disabled: source.isnGetLatLong.value,
        controller: source.inputVillage,
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
        disabled: source.isnGetLatLong.value,
        controller: source.inputPostal,
        hintText: BaseText.hintText(field: PCustomerText.labelPostal),
      ),
    );
  }

  Widget inputContactName() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelContactName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputContactName,
        hintText: BaseText.hintText(field: PCustomerText.labelContactName),
        validators: [
          Validators.inputRequired(PCustomerText.labelContactName),
          Validators.maxLength(PCustomerText.labelContactName, 255)
        ],
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
        disabled: source.isProcessing,
        controller: source.selectCustomer,
        hintText: BaseText.hiintSelect(field: PCustomerText.labelCustomer),
        serverSide: (params) => selectApiCustomer(params),
        validators: [
          Validators.selectRequired(PCustomerText.labelCustomer),
        ],
      ),
    );
  }

  Widget selectContactType() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelContactType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectContactType,
        hintText: BaseText.hiintSelect(field: PCustomerText.labelContactType),
        serverSide: (params) => selectApiContactTypes(params),
        validators: [
          Validators.selectRequired(PCustomerText.labelContactType),
        ],
      ),
    );
  }

  Widget inputValue() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelValue,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        minLines: 3,
        maxLines: 5,
        disabled: source.isProcessing,
        controller: source.inputValue,
        hintText: BaseText.hintText(field: PCustomerText.labelValue),
      ),
    );
  }

  Widget checkBox() {
    return BsRow(
      children: [
        BsCol(
          sizes: ColScreen(sm: Col.col_2),
          child: Obx(() => Row(
                children: [
                  Text(PCustomerText.labelRegistered,
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold)),
                  Checkbox(
                    value: source.isRegistered.value,
                    onChanged: (value) => source.isRegistered.toggle(),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget selectBpCustomerTypes() {
    return FormGroup(
      label: Obx(() => Text(PCustomerText.labelBpCustomerType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectStatus,
        hintText:
            BaseText.hiintSelect(field: PCustomerText.labelBpCustomerType),
        serverSide: (params) => selectApiBpCustomerStatus(params),
        validators: [
          Validators.selectRequired(PCustomerText.labelBpCustomerType),
        ],
      ),
    );
  }
}
