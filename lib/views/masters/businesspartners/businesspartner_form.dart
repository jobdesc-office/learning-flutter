import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/businesspartner_model.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/businesspartner_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '../../../widgets/form_group.dart';
import '_form_source.dart';
import '_businesspartner_type.dart';

// ignore: must_be_immutable
class BusinessPartnerFormView extends StatelessWidget
    implements EditViewContract, BusinessPartnerTypeViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final BusinessPartnerPresenter presenter =
      Get.find<BusinessPartnerPresenter>();
  final source = BusinessPartnerSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  late BusinessPartnerForm businessPartnerForm;

  BusinessPartnerFormView({required this.onSave}) {
    presenter.businessPartnerFetchDataContract = this;
    presenter.businessPartnerTypeViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Business Partner Form',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget(
            'Business Partner',
            back: true,
          ),
          BreadcrumbWidget('Business Partner Form', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.masterBusinessPartner.index
        ],
        child: Obx(() {
          businessPartnerForm = BusinessPartnerForm(source.value);
          return BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_6),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
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
                  ),
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(lg: Col.col_6),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BsRow(
                    children: [
                      BsCol(
                        child: BsRow(
                          children: [
                            BsCol(
                              child: FormGroup(
                                  label: Text('Created By',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.createdby.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Created At',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.createddate.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Last Updated By',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.updatedby.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Last Updated At',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.updateddate.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Activation',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (source.value.isactive.value)
                                        InkWell(
                                          child: Icon(
                                            Icons.toggle_on,
                                            size: 35,
                                            color: _navigation.darkTheme.value
                                                ? ColorPallates.onDarkMode
                                                : ColorPallates.onLightMode,
                                          ),
                                          onTap: () =>
                                              source.value.isactive.toggle(),
                                        )
                                      else
                                        InkWell(
                                          child: Icon(
                                            Icons.toggle_off,
                                            size: 35,
                                            color: _navigation.darkTheme.value
                                                ? ColorPallates.offDarkMode
                                                : ColorPallates.offLightMode,
                                          ),
                                          onTap: () =>
                                              source.value.isactive.toggle(),
                                        ),
                                      Divider()
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
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
      source.value.selectType.setSelected(BsSelectBoxOption(
          value: bp.bptypeid, text: Text(bp.bptype?.typename ?? '')));
      source.value.businessPartnerTypeController.selected = bp.bptype;
      source.value.inputCompanyName.text = bp.bpname ?? '';
      source.value.inputName.text = bp.bppicname ?? '';
      source.value.inputEmail.text = bp.bpemail ?? '';
      source.value.inputPhone.text = bp.bpphone ?? '';

      source.value.createdby.value = bp.bpcreatedby?.userfullname ?? '';
      source.value.createddate.value = bp.createddate ?? '';
      source.value.updatedby.value = bp.bpupdatedby?.userfullname ?? '';
      source.value.updateddate.value = bp.updateddate ?? '';
      source.value.isactive.value = bp.isactive ?? true;
    });
  }
}
