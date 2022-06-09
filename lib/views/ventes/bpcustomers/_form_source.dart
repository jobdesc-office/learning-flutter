import 'dart:typed_data';
import 'dart:io';

import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/ventes/bpcustomer_presenter.dart';
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
final _presenter = Get.find<BpCustomerPresenter>();

class BpCustomerSource extends GetxController {
  bool isProcessing = false;
  var isnGetLatLong = true.obs;
  // var pic =
  //     'https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png'.obs;
  var pic =
      XFile('https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png')
          .obs;

  File? image;

  Future<File> _getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectBp = BsSelectBoxController();
  BsSelectBoxController selectCustomer = BsSelectBoxController();

  void uploadImage() {}

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'sbcbpid': selectBp.getSelectedAsString(),
      'cstmid': selectCustomer.getSelectedAsString(),
      'sbccstmstatusid': selectType.getSelectedAsString(),
      'sbccstmpic': image?.path,
      // 'sbccstmpic': pic.value,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class BpCustomerForm {
  final BpCustomerSource source;
  final map = Get.put(mapSource());
  final BpCustomerPresenter presenter = Get.find<BpCustomerPresenter>();
  final ImagePicker _picker = ImagePicker();

  BpCustomerForm(this.source);

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(BpCustomerText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: BpCustomerText.labelType),
        serverSide: (params) => selectApiBpCustomerStatus(params),
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
      ),
    );
  }

  Widget btnImage() {
    return FormGroup(
      label: Obx(() => Text(BpCustomerText.labelImage,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Column(
        children: [
          if (source.pic != null) Image.network(source.pic.value.path),
          BsButton(
            margin: EdgeInsets.only(top: 10),
            onPressed: () async {
              final XFile? photos =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (photos != null) {
                source.pic.value = photos;
                source.image = File(photos.path);
              }
            },
            label: Text(
              BpCustomerText.labelImage,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
