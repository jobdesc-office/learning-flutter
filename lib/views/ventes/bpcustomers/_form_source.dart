import 'dart:typed_data';

import 'package:boilerplate/helpers/function.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/masters/customer_presenter.dart';
import '../../../presenters/ventes/bpcustomer_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class BpCustomerSource {
  final customerPresenter = Get.find<CustomerPresenter>();
  bool isProcessing = false;
  var isnGetLatLong = true.obs;

  var imgname = ''.obs;
  var image = Uint8List(1).obs;
  var imageupdate =
      'http://10.21.1.63/learning-api/public/storage/images/ventes-28March2022-defaultuser.png'
          .obs;
  var isImage = false.obs;
  var isUpdate = false.obs;

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectBp = BsSelectBoxController();
  BsSelectBoxController selectCustomer = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    String name = await customerPresenter
        .cstm(parseInt(selectCustomer.getSelectedAsString()));
    imgname.value = name;

    SessionModel session = await SessionManager.current();
    return {
      'sbcbpid': selectBp.getSelectedAsString(),
      'cstmid': selectCustomer.getSelectedAsString(),
      'sbccstmstatusid': selectType.getSelectedAsString(),
      'sbccstmpic': MultipartFile(image.value, filename: imgname.value),
      'createdby': session.userid,
      'updatedby': session.userid,
      '_method': isUpdate.value ? 'put' : null
    };
  }
}

class BpCustomerForm extends GetxController {
  final BpCustomerSource source;
  final map = Get.put(MapSource());
  final BpCustomerPresenter presenter = Get.find<BpCustomerPresenter>();

  BpCustomerForm(this.source);

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(BpCustomerText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: BpCustomerText.labelType),
        serverSide: (params) => selectApiBpCustomerStatus(params),
        validators: [
          Validators.selectRequired(BpCustomerText.labelType),
        ],
      ),
    );
  }

  Widget selectBp() {
    return FormGroup(
      label: Obx(() => Text(BpCustomerText.labelBp,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectBp,
        hintText: BaseText.hiintSelect(field: BpCustomerText.labelBp),
        serverSide: (params) => selectApiPartner(params),
        validators: [
          Validators.selectRequired(BpCustomerText.labelBp),
        ],
      ),
    );
  }

  Widget selectCustomer() {
    return FormGroup(
      label: Obx(() => Text(BpCustomerText.labelCustomer,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectCustomer,
        hintText: BaseText.hiintSelect(field: BpCustomerText.labelCustomer),
        serverSide: (params) => selectApiCustomer(params),
        validators: [
          Validators.selectRequired(BpCustomerText.labelCustomer),
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
                if (source.isUpdate.value)
                  Image.network(source.imageupdate.value),
                BsButton(
                  margin: EdgeInsets.only(top: 10),
                  onPressed: () async {
                    Uint8List? fromPicker =
                        await ImagePickerWeb.getImageAsBytes();
                    if (fromPicker != null) {
                      source.isUpdate.value = false;
                      source.image.value = fromPicker;
                      source.isImage.value = true;
                    }
                  },
                  label: Text(
                    BpCustomerText.labelImage,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
