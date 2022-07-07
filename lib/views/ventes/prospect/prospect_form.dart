import 'package:boilerplate/services/ventes/customfield_service.dart';
import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../models/ventes/prospect_model.dart';
import '../../../presenters/ventes/prospect_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '../../masters/menus/_menu_type.dart';
import '_form_source.dart';

class ProspectFormView extends StatelessWidget
    implements EditViewContract, MenuTypeViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectPresenter presenter = Get.find<ProspectPresenter>();
  final source = ProspectSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ProspectForm prospectForm;

  ProspectFormView({required this.onSave}) {
    presenter.ProspectFetchDataContract = this;
    presenter.prospectTypeViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Prospect Form',
        breadcrumbs: [
          BreadcrumbWidget('Dashboard', route: RouteList.home.index),
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Prospect', back: true),
          BreadcrumbWidget('Prospect Form', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        child: Obx(() {
          prospectForm = ProspectForm(source.value);
          return Form(
            key: formState,
            child: BsRow(
              children: [
                BsCol(
                  margin: EdgeInsets.only(right: 5),
                  sizes: ColScreen(sm: Col.col_5),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          prospectForm.inputTitle(),
                          prospectForm.selectBp(),
                          prospectForm.selectOwner(),
                          prospectForm.inputStatus(),
                          prospectForm.inputPipelineStage()
                        ],
                      ),
                    ),
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.only(left: 5),
                  sizes: ColScreen(sm: Col.col_7),
                  child: BsRow(
                    children: [
                      BsCol(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // prospectForm.inputEmail(
                                  //     onRemoveEmail: onClickRemoveEmail),
                                  // Container(
                                  //   margin: EdgeInsets.only(bottom: 20),
                                  //   child: GestureDetector(
                                  //       onTap: () {
                                  //         source.update((val) {
                                  //           source.value.inputEmails
                                  //               .add(TextEditingController());
                                  //           source.value.selectsPrivationEmail
                                  //               .add(BsSelectBoxController(
                                  //                   options: [
                                  //                 BsSelectBoxOption(
                                  //                     value: '{1}',
                                  //                     text: Text("Work")),
                                  //                 BsSelectBoxOption(
                                  //                     value: '{2}',
                                  //                     text: Text('Private'))
                                  //               ]));
                                  //         });
                                  //       },
                                  //       child: Text('+ Add More Emails')),
                                  // ),
                                  // prospectForm.inputPhone(
                                  //     onRemovePhone: onClickRemovePhone),
                                  // Container(
                                  //   margin: EdgeInsets.only(bottom: 20),
                                  //   child: GestureDetector(
                                  //       onTap: () {
                                  //         source.update((val) {
                                  //           source.value.inputPhones
                                  //               .add(TextEditingController());
                                  //           source.value.selectsPrivationPhone
                                  //               .add(BsSelectBoxController(
                                  //                   options: [
                                  //                 BsSelectBoxOption(
                                  //                     value: '{1}',
                                  //                     text: Text("Work")),
                                  //                 BsSelectBoxOption(
                                  //                     value: '{2}',
                                  //                     text: Text('Private'))
                                  //               ]));
                                  //         });
                                  //       },
                                  //       child: Text('+ Add More Phones')),
                                  // ),
                                  BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_7),
                                          child: prospectForm
                                              .inputExpected(context)),
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_7),
                                          child: prospectForm
                                              .inputOrganization(context)),
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_7),
                                          child:
                                              prospectForm.selectReference()),
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_7),
                                          child: prospectForm.inputValue()),
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_7),
                                          child: prospectForm.inputDesc()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(top: 5),
                        child: source.value.isProduct.value
                            ? null
                            : Container(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey.shade300)),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        prospectForm.inputProduct(
                                            onRemoveItem: onClickRemoveItem),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    source.update((val) {
                                                      source.value.inputPrices.add(
                                                          TextEditingController());
                                                      source
                                                          .value.inputQuantities
                                                          .add(
                                                              TextEditingController());
                                                      source.value.inputAmounts.add(
                                                          TextEditingController());
                                                      source.value.inputTaxes.add(
                                                          TextEditingController());
                                                      source.value.selectsItem.add(
                                                          BsSelectBoxController());
                                                      source
                                                          .value.inputDiscounts
                                                          .add(
                                                              TextEditingController());
                                                      source.value.selectsTax.add(
                                                          BsSelectBoxController());
                                                    });
                                                  },
                                                  child:
                                                      Text('+ Add More Items')),
                                              // prospectForm.total()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(top: 20),
                        child: Obx(
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
                      )
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

  // void onClickRemoveEmail(int index) {
  //   source.update((val) {
  //     source.value.inputEmails.removeAt(index);
  //     source.value.selectsPrivationEmail.removeAt(index);
  //   });
  // }

  // void onClickRemovePhone(int index) {
  //   source.update((val) {
  //     source.value.inputPhones.removeAt(index);
  //     source.value.selectsPrivationPhone.removeAt(index);
  //   });
  // }

  void onClickRemoveItem(int index) {
    source.update((val) {
      source.value.selectsItem.removeAt(index);
      source.value.inputPrices.removeAt(index);
      source.value.inputQuantities.removeAt(index);
      source.value.inputAmounts.removeAt(index);
      source.value.inputDiscounts.removeAt(index);
      source.value.inputTaxes.removeAt(index);
      source.value.selectsTax.removeAt(index);
    });
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
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');

    source.update((val) {
      ProspectModel prospect = ProspectModel.fromJson(response.body);
      source.value.prospectStageController.selected = prospect.prospectstage;
      source.value.selectBp.setSelected(BsSelectBoxOption(
          value: prospect.prospectbpid,
          text: Text(prospect.prospectbp!.bpname!)));
      authPresenter.bpActiveId.value = prospect.prospectbpid!;
      source.value.isBpNotSelected.value = false;
      source.value.selectOwner.setSelected(BsSelectBoxOption(
          value: prospect.prospectowneruser!.user!.userid,
          text: Text(prospect.prospectowneruser!.user!.userfullname!)));

      if (prospect.prospectreference != null) {
        source.value.selectReference.setSelected(BsSelectBoxOption(
            value: prospect.prospectreference!.prospectid,
            text: Text(prospect.prospectreference!.prospectname! +
                ' || ' +
                prospect.prospectreference!.prospectcust!.sbccstmname!)));
      }

      source.value.selectCustomer.setSelected(BsSelectBoxOption(
          value: prospect.prospectcust!.sbcid,
          text: Text(prospect.prospectcust!.sbccstmname.toString())));
      source.value.inputCompanyName.text = prospect.prospectname ?? '';
      source.value.selectStatus.setSelected(BsSelectBoxOption(
          value: prospect.prospectstatus!.typeid,
          text: Text(prospect.prospectstatus!.typename.toString())));

      if (prospect.prospectvalue != null) {
        source.value.inputValue.text = currencyFormatter
            .format(double.parse(prospect.prospectvalue!))
            .replaceAll(',00', '')
            .replaceAll('.', ',');
      }

      source.value.inputDesc.text = prospect.prospectdescription ?? '';

      source.value.selectedDateStart.value = prospect.prospectstartdate ?? '';
      source.value.selectedDateEnd.value = prospect.prospectenddate ?? '';
      source.value.selectedDateExpect.value =
          prospect.prospectexpclosedate ?? '';

      for (var item in prospect.prospectproduct!) {
        source.value.selectsItem.add(BsSelectBoxController(selected: [
          BsSelectBoxOption(
              value: item.prosproductproductid,
              text: Text(item.prosproductproduct!.productname!))
        ]));
        source.value.inputPrices.add(TextEditingController(
            text: currencyFormatter
                .format(double.parse(item.prosproductprice!))
                .replaceAll(',00', '')
                .replaceAll('.', ',')));
        source.value.inputQuantities
            .add(TextEditingController(text: item.prosproductqty.toString()));
        source.value.inputAmounts.add(TextEditingController(
            text: currencyFormatter
                .format(double.parse(item.prosproductamount!))));
        source.value.inputDiscounts
            .add(TextEditingController(text: item.prosproductdiscount ?? ''));
        source.value.inputTaxes
            .add(TextEditingController(text: item.prosproducttax ?? ''));
        if (item.prosproducttaxtype != null) {
          source.value.selectsTax.add(BsSelectBoxController(selected: [
            BsSelectBoxOption(
                value: item.prosproducttaxtype!.typeid,
                text: Text(item.prosproducttaxtype!.typename!))
          ]));
        } else {
          source.value.selectsTax.add(BsSelectBoxController());
        }
      }
    });
  }

  @override
  void onLoadSuccess(Response response) {
    source.update((val) {
      source.value.prospectStageController.options = List<TypeModel>.from(
        response.body.map((data) {
          return TypeModel.fromJson(data);
        }),
      );
    });
  }
}
