import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';
import '../../masters/menus/_menu_type.dart';
import '_form_source.dart';
import '_text.dart';

class ScheduleFormView extends StatelessWidget
    implements EditViewContract, MenuTypeViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final SchedulePresenter presenter = Get.find<SchedulePresenter>();
  final source = ScheduleSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ScheduleForm menuForm;

  ScheduleFormView({required this.onSave}) {
    // presenter.menuFetchDataContract = this;
    // presenter.menuTypeViewContract = this;
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
              title: Text(ScheduleText.title),
              closeButton: true,
            ),
            BsModalContainer(
              child: Obx(() {
                menuForm = ScheduleForm(source.value);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    menuForm.inputName(),
                    menuForm.inputDate(context),
                    menuForm.inputTime(context),
                    menuForm.actDate(context),
                    menuForm.selectType()
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
  void onLoadSuccess(Response response) {
    // TODO: implement onLoadSuccess
  }

  @override
  void onSuccessFetchData(Response response) {
    // TODO: implement onSuccessFetchData
  }
}
