import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/contact_model.dart';
import '../../../presenters/masters/contact_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

class ContactFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ContactPresenter presenter = Get.find<ContactPresenter>();
  final source = ContactSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ContactForm contactForm;

  ContactFormView({required this.onSave}) {
    presenter.contactFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        activeRoutes: [RouteList.master.index, RouteList.masterContact.index],
        child: Obx(() {
          contactForm = ContactForm(source.value);
          return Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contactForm.selectCustomer(),
                contactForm.selectType(),
                contactForm.inputValue(),
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
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      ContactModel contact = ContactModel.fromJson(response.body);
      source.value.inputValue.text = contact.contactvalueid!;
      source.value.selectCustomer.setSelected(BsSelectBoxOption(
          value: contact.contactcustomer!.cstmid,
          text: Text(contact.contactcustomer!.cstmname!)));
      source.value.selectType.setSelected(BsSelectBoxOption(
          value: contact.contacttype!.typeid,
          text: Text(contact.contacttype!.typename!)));
    });
  }
}
