import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/typeparent_presenter.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';
import '_text.dart';

class TypeParentFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TypeParentPresenter presenter = Get.find<TypeParentPresenter>();
  final source = TypeParentSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late TypeParentForm tpForm;

  TypeParentFormView({required this.onSave}) {
    presenter.typeParentFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: BsModal(
        context: context,
        dialog: BsModalDialog(
          child: BsModalContent(children: [
            BsModalContainer(
              title: Text(TypeParentsText.title),
              closeButton: true,
            ),
            BsModalContainer(
              child: Obx(() {
                tpForm = TypeParentForm(source.value);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tpForm.inputCode(),
                    tpForm.inputName(),
                    tpForm.inputSeq(),
                    tpForm.inputDesc(),
                  ],
                );
              }),
            ),
            BsModalContainer(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ThemeButtonCancel(
                      disabled: presenter.isProcessing.value,
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onClickCancelModal(context),
                    ),
                    ThemeButtonSave(
                      disabled: presenter.isProcessing.value,
                      processing: presenter.isProcessing.value,
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onClickSaveModal(context),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate()) onSave(await source.toJson());
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      TypeModel menu = TypeModel.fromJson(response.body);
      source.value.inputName.text = menu.typename;
      source.value.inputCode.text = menu.typecd;
      source.value.inputSeq.text = menu.typeseq.toString();
      source.value.inputDesc.text = menu.description;
    });
  }
}
