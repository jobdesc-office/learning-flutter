import 'dart:typed_data';

import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class CompetitorSource extends GetxController {
  bool isProcessing = false;
  var isnGetLatLong = true.obs;

  var transtypeid = 0.obs;
  var refid = 0.obs;

  var imgname = ''.obs;
  var image = <Uint8List>[].obs;
  var imageupdate = [].obs;
  var isImage = false.obs;
  var isUpdate = false.obs;
  var isUpdateImage = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputProductName = TextEditingController();
  TextEditingController inputDesc = TextEditingController();

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectBp = BsSelectBoxController();
  BsSelectBoxController selectRef = BsSelectBoxController();

  List<MultipartFile> jsonImages() {
    List<MultipartFile> img = [];
    int no = 0;
    for (var item in image) {
      no++;
      img.add(MultipartFile(item, filename: inputName.text + no.toString()));
    }
    return img;
  }

  Future<Map<String, dynamic>> toJson() async {
    final box = GetStorage();
    SessionModel session = await SessionManager.current();
    return {
      'comptbpid': box.read('mybpid').toString(),
      'comptreftypeid': selectType.getSelectedAsString(),
      'comptrefid': selectRef.getSelectedAsString() != ''
          ? selectRef.getSelectedAsString()
          : null,
      'comptname': inputName.text,
      'comptproductname': inputProductName.text,
      'description': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
      'comptpics[]': jsonImages(),
      '_method': isUpdateImage.value ? 'put' : null
    };
  }
}

class CompetitorForm {
  final CompetitorSource source;

  CompetitorForm(this.source);

  Widget photoViewer() {
    var gallery;
    switch (source.image.length) {
      case 3:
        gallery = Obx(() => BsRow(
              children: source.image.map((element) {
                return BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_4),
                    child: InkWell(
                        onTap: (() => source.image
                            .removeWhere((item) => item == element)),
                        child: Tooltip(
                            message: 'Tap to Remove',
                            child: Image.memory(element))));
              }).toList(),
            ));
        break;
      case 2:
        gallery = Obx(() => BsRow(
              children: source.image.map((element) {
                return BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_6),
                    child: InkWell(
                        onTap: (() => source.image
                            .removeWhere((item) => item == element)),
                        child: Tooltip(
                            message: 'Tap to Remove',
                            child: Image.memory(element))));
              }).toList(),
            ));
        break;
      case 1:
        gallery = Obx(() => BsRow(
              children: source.image.map((element) {
                return BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_12),
                    child: InkWell(
                        onTap: (() => source.image
                            .removeWhere((item) => item == element)),
                        child: Tooltip(
                            message: 'Tap to Remove',
                            child: Image.memory(element))));
              }).toList(),
            ));
        break;
      default:
        gallery = Obx(() => BsRow(
              children: source.image.map((element) {
                return BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_3),
                    child: InkWell(
                        onTap: (() => source.image
                            .removeWhere((item) => item == element)),
                        child: Tooltip(
                            message: 'Tap to Remove',
                            child: Image.memory(element))));
              }).toList(),
            ));
    }
    return gallery;
  }

  Widget photoViewerUpdate() {
    var gallery;
    switch (source.imageupdate.length) {
      case 3:
        gallery = Obx(() => BsRow(
              children: source.imageupdate.map((element) {
                return BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_4),
                    child: InkWell(
                        onTap: (() => source.imageupdate
                            .removeWhere((item) => item == element)),
                        child: Tooltip(
                            message: 'Tap to Remove',
                            child: Image.network(element))));
              }).toList(),
            ));
        break;
      case 2:
        gallery = Obx(() => BsRow(
              children: source.imageupdate.map((element) {
                return BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_6),
                    child: InkWell(
                        onTap: (() => source.imageupdate
                            .removeWhere((item) => item == element)),
                        child: Tooltip(
                            message: 'Tap to Remove',
                            child: Image.network(element))));
              }).toList(),
            ));
        break;
      case 1:
        gallery = Obx(() => BsRow(
              children: source.imageupdate.map((element) {
                return BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_12),
                    child: InkWell(
                        onTap: (() => source.imageupdate
                            .removeWhere((item) => item == element)),
                        child: Tooltip(
                            message: 'Tap to Remove',
                            child: Image.network(element))));
              }).toList(),
            ));
        break;
      default:
        gallery = Obx(() => BsRow(
              children: source.imageupdate.map((element) {
                return BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_3),
                    child: InkWell(
                        onTap: (() => source.imageupdate
                            .removeWhere((item) => item == element)),
                        child: Tooltip(
                            message: 'Tap to Remove',
                            child: Image.network(element))));
              }).toList(),
            ));
    }
    return gallery;
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: CompetitorText.labelName),
        validators: [
          Validators.inputRequired(CompetitorText.labelName),
        ],
      ),
    );
  }

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: CompetitorText.labelType),
        serverSide: (params) => selectApiCompetitorRefType(params),
      ),
    );
  }

  Widget selectBp() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelBp,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectBp,
        hintText: BaseText.hiintSelect(field: CompetitorText.labelBp),
        serverSide: (params) => selectApiPartner(params),
      ),
    );
  }

  Widget selectRef() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelRef,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectRef,
        hintText: BaseText.hiintSelect(field: CompetitorText.labelRef),
        serverSide: (params) => selectApiProspect(params),
        validators: [],
      ),
    );
  }

  Widget inputProductName() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelProductName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputProductName,
        hintText: BaseText.hintText(field: CompetitorText.labelProductName),
        validators: [],
      ),
    );
  }

  Widget inputDesciption() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelDesc,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: CompetitorText.labelDesc),
        validators: [],
        minLines: 2,
        maxLines: 5,
      ),
    );
  }

  Widget btnImage() {
    return FormGroup(
      child: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (source.isImage.value) photoViewer(),
                if (source.isUpdate.value) photoViewerUpdate(),
                BsButton(
                  margin: EdgeInsets.only(top: 10),
                  onPressed: () async {
                    List<Uint8List>? fromPicker =
                        await ImagePickerWeb.getMultiImagesAsBytes();
                    if (fromPicker != null) {
                      source.image.clear();
                      source.isUpdate.value = false;
                      source.image.value = fromPicker;
                      source.isImage.value = true;
                    }
                  },
                  label: Text(
                    CompetitorText.labelImage,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
