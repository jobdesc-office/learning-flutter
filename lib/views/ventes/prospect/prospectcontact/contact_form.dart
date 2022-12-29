import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/edit_view_contract.dart';
import '../../../../models/masters/contact_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospectcontact_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '_form_source.dart';

// ignore: must_be_immutable
class ProspectContactFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectContactPresenter presenter = Get.find<ProspectContactPresenter>();
  final source = ProspectContactSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  late ProspectContactForm prospectContactForm;

  ProspectContactFormView({required this.onSave, id}) {
    presenter.setprospectFetchDataContract = this;
    source.value.id.value = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'ProspectContact Form',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('ProspectContact', back: true),
          BreadcrumbWidget('ProspectContact Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesProspect.index],
        child: Obx(() {
          prospectContactForm = ProspectContactForm(source.value);
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  prospectContactForm.inputName(),
                  prospectContactForm.selectType(),
                  prospectContactForm.inputValue(),
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
      ContactModel prospectContact = ContactModel.fromJson(response.body);
      source.value.inputValue.text = prospectContact.contactvalueid!;
      source.value.inputName.text = prospectContact.contactname!;
      source.value.selectType.setSelected(BsSelectBoxOption(value: prospectContact.contacttype!.sbtid, text: Text(prospectContact.contacttype!.sbttypename!)));
    });
  }
}
