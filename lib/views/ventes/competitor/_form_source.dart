import 'dart:typed_data';

import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:get/get.dart';
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

  var imgname = ''.obs;
  var image = <Uint8List>[].obs;
  var imageupdate =
      'http://10.21.1.63/learning-api/public/storage/files/defaultuser.png'.obs;
  var isImage = false.obs;
  var isUpdate = false.obs;

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
    SessionModel session = await SessionManager.current();
    return {
      'comptbpid': selectBp.getSelectedAsString(),
      'comptreftypeid': selectType.getSelectedAsString(),
      'comptrefid': selectRef.getSelectedAsString(),
      'comptname': inputName.text,
      'comptproductname': inputProductName.text,
      'description': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'comptpics': jsonImages(),
    };
  }
}

class CompetitorForm {
  final CompetitorSource source;

  CompetitorForm(this.source);

  Widget gallery() {
    return Gallery3D(
        delayTime: 2000,
        width: 500,
        itemConfig: GalleryItemConfig(
          width: 200,
          height: 270,
          radius: 10,
          isShowTransformMask: false,
        ),
        itemCount: source.image.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              source.image.removeAt(index);
            },
            child: Tooltip(
              message: 'Tap to Remove',
              child: Image.memory(
                source.image[index],
                fit: BoxFit.fill,
              ),
            ),
          );
        });
  }

  Widget photoViewer() {
    if (source.image.length >= 3) {
      return Obx(() => gallery());
    } else if (source.image.length == 2) {
      return Obx(() => BsRow(
            children: source.image.map((element) {
              return BsCol(
                  sizes: ColScreen(sm: Col.col_6),
                  child: InkWell(
                      onTap: (() =>
                          source.image.removeWhere((item) => item == element)),
                      child: Tooltip(
                          message: 'Tap to Remove',
                          child: Image.memory(element))));
            }).toList(),
          ));
    } else {
      return Obx(() => BsRow(
            children: source.image.map((element) {
              return BsCol(
                  sizes: ColScreen(sm: Col.col_12),
                  child: InkWell(
                      onTap: (() =>
                          source.image.removeWhere((item) => item == element)),
                      child: Tooltip(
                          message: 'Tap to Remove',
                          child: Image.memory(element))));
            }).toList(),
          ));
    }
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
