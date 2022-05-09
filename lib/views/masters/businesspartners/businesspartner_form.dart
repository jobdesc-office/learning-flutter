import 'package:boilerplate/views/skins/tempalte.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/businesspartner_model.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/businesspartner_presenter.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';
import '_businesspartner_type.dart';
import '_text.dart';

class BusinessPartnerFormView extends StatelessWidget
    implements EditViewContract, BusinessPartnerTypeViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final BusinessPartnerPresenter presenter =
      Get.find<BusinessPartnerPresenter>();
  final source = BusinessPartnerSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late BusinessPartnerForm businessPartnerForm;

  BusinessPartnerFormView({required this.onSave}) {
    presenter.businessPartnerFetchDataContract = this;
    presenter.businessPartnerTypeViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        child: Obx(() {
          businessPartnerForm = BusinessPartnerForm(source.value);
          return Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                businessPartnerForm.businessPartnerType(),
                businessPartnerForm.inputCompanyName(),
                businessPartnerForm.inputName(),
                businessPartnerForm.inputEmail(),
                businessPartnerForm.inputPhone(),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ThemeButtonSave(
                        disabled: presenter.isProcessing.value,
                        processing: presenter.isProcessing.value,
                        margin: EdgeInsets.only(right: 5),
                        onPressed: () => onClickSaveModal(context),
                      ),
                      ThemeButtonCancel(
                        disabled: presenter.isProcessing.value,
                        margin: EdgeInsets.only(right: 5),
                        onPressed: () => onClickCancelModal(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate())
      onSave(await source.toJson());
    else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onLoadSuccess(Response response) {
    source.update((val) {
      source.value.businessPartnerTypeController.options = List<TypeModel>.from(
        response.body.map((data) {
          return TypeModel.fromJson(data);
        }),
      );
    });
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      BusinessPartnerModel bp = BusinessPartnerModel.fromJson(response.body);
      source.value.businessPartnerTypeController.selected = bp.bptype;
      source.value.inputCompanyName.text = bp.bpname;
      source.value.inputName.text = bp.bppicname;
      source.value.inputEmail.text = bp.bpemail;
      source.value.inputPhone.text = bp.bpphone;
    });
  }
}
