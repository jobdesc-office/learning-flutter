import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/ventes/bpcustomer_model.dart';
import '../../../presenters/ventes/bpcustomer_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

class BpCustomerFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final BpCustomerPresenter presenter = Get.find<BpCustomerPresenter>();
  final source = BpCustomerSource().obs;
  final Function(dynamic body) onSave;

  late final BpCustomerForm bpCustomerForm;

  BpCustomerFormView({required this.onSave}) {
    presenter.bpCustomerFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'BpCustomer Form',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('BpCustomers', back: true),
          BreadcrumbWidget('BpCustomer Form', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.ventesBpCustomer.index
        ],
        child: Obx(() {
          bpCustomerForm = BpCustomerForm(source.value);
          return Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BsRow(
                  children: [
                    BsCol(
                      margin: EdgeInsets.only(bottom: 10),
                      sizes: ColScreen(sm: Col.col_4),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              // bpCustomerForm.inputName(),
                              // bpCustomerForm.inputPhone(),
                              // bpCustomerForm.inputAddress(),
                              bpCustomerForm.btnImage(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BsCol(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      sizes: ColScreen(sm: Col.col_8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              bpCustomerForm.selectCustomer(),
                              bpCustomerForm.selectBp(),
                              bpCustomerForm.selectTypes()
                            ],
                          ),
                        ),
                      ),
                    )
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
          );
        }),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate()) {
      onSave(await source.toJson());
    } else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      BusinessPartnerCustomerModel bpCustomer =
          BusinessPartnerCustomerModel.fromJson(response.body);
      source.value.selectType.setSelected(BsSelectBoxOption(
          value: bpCustomer.sbccstmstatus!.typeid,
          text: Text(bpCustomer.sbccstmstatus!.typename.toString())));
      source.value.selectBp.setSelected(BsSelectBoxOption(
          value: bpCustomer.sbcbp!.bpid,
          text: Text(bpCustomer.sbcbp!.bpname.toString())));
      source.value.selectCustomer.setSelected(BsSelectBoxOption(
          value: bpCustomer.sbccstm!.cstmid,
          text: Text(bpCustomer.sbccstm!.cstmname.toString())));
      source.value.image.value = Image(
          image: NetworkImage(
              '${bpCustomer.sbccstmpic ?? 'https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png'}'));
    });
  }
}
