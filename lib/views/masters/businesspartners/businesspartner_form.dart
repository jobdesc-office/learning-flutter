import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/models/masters/bpquota_model.dart';
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
import '../../../presenters/masters/typechildren_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '../../../widgets/form_group.dart';
import '../../../widgets/snackbar.dart';
import '_form_source.dart';
import '_businesspartner_type.dart';

final typePresenter = Get.find<TypesChildrenPresenter>();

// ignore: must_be_immutable
class BusinessPartnerFormView extends StatelessWidget
    implements
        EditViewContract,
        BusinessPartnerTypeViewContract,
        IndexViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final BusinessPartnerPresenter presenter =
      Get.find<BusinessPartnerPresenter>();
  final source = BusinessPartnerSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  var isEdit = false.obs;

  late BusinessPartnerForm businessPartnerForm;

  BusinessPartnerFormView({required this.onSave}) {
    presenter.businessPartnerFetchDataContract = this;
    presenter.businessPartnerTypeViewContract = this;
    typePresenter.typeChildrenViewContract = this;
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
          return Form(
            key: formState,
            child: BsRow(
              children: [
                BsCol(
                  sizes: ColScreen(sm: Col.col_12),
                  child: BsRow(
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              businessPartnerForm.businessPartnerType(context),
                              businessPartnerForm.inputCompanyName(),
                              businessPartnerForm.inputName(),
                              businessPartnerForm.inputEmail(),
                              businessPartnerForm.inputPhone(),
                            ],
                          ),
                        ),
                      ),
                      if (isEdit.value)
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
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(source
                                                    .value.createdby.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroup(
                                            label: Text('Created At',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(source
                                                    .value.createddate.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroup(
                                            label: Text('Last Updated By',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(source
                                                    .value.updatedby.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroup(
                                            label: Text('Last Updated At',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(source
                                                    .value.updateddate.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroup(
                                            label: Text('Is Active',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
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
                                                      color: _navigation
                                                              .darkTheme.value
                                                          ? ColorPallates
                                                              .onDarkMode
                                                          : ColorPallates
                                                              .onLightMode,
                                                    ),
                                                    onTap: () => source
                                                        .value.isactive
                                                        .toggle(),
                                                  )
                                                else
                                                  InkWell(
                                                    child: Icon(
                                                      Icons.toggle_off,
                                                      size: 35,
                                                      color: _navigation
                                                              .darkTheme.value
                                                          ? ColorPallates
                                                              .offDarkMode
                                                          : ColorPallates
                                                              .offLightMode,
                                                    ),
                                                    onTap: () => source
                                                        .value.isactive
                                                        .toggle(),
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
                        ),
                    ],
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.only(top: 8),
                  sizes: ColScreen(sm: Col.col_12),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _navigation.darkTheme.value
                          ? ColorPallates.elseDarkColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Business Partner Settings",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(child: businessPartnerForm.inputUserWeb()),
                            SizedBox(width: 8),
                            Expanded(
                                child: businessPartnerForm.inputUserMobile()),
                          ],
                        ),
                        businessPartnerForm.inputCustomer(),
                        businessPartnerForm.inputContact(),
                        businessPartnerForm.inputProduct(),
                        businessPartnerForm.inputProspect(),
                        Row(
                          children: [
                            Expanded(
                                child:
                                    businessPartnerForm.inputDailyActivity()),
                            SizedBox(width: 8),
                            Expanded(
                                child: businessPartnerForm
                                    .inputProspectActivity()),
                          ],
                        ),
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
    isEdit.value = true;

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

      source.value.inputUserWeb.text =
          bp.quota?.sbqwebuserquota?.toString() ?? "0";
      source.value.inputUserMobile.text =
          bp.quota?.sbqmobuserquota?.toString() ?? "0";
      source.value.inputCustomer.text =
          bp.quota?.sbqcstmquota?.toString() ?? "0";
      source.value.inputContact.text =
          bp.quota?.sbqcntcquota?.toString() ?? "0";
      source.value.inputProduct.text =
          bp.quota?.sbqprodquota?.toString() ?? "0";
      source.value.inputProspect.text =
          bp.quota?.sbqprosquota?.toString() ?? "0";
      source.value.inputDailyActivity.text =
          bp.quota?.sbqdayactquota?.toString() ?? "0";
      source.value.inputProspectActivity.text =
          bp.quota?.sbqprosactquota?.toString() ?? "0";
      source.value.quota.value = bp.quota;
    });
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    source.value.selectType.clear();
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onDeleteSuccess
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onEditSuccess
  }

  @override
  void onErrorRequest(Response response, {context}) {
    // TODO: implement onErrorRequest
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    // TODO: implement onLoadDatatables
  }
}
