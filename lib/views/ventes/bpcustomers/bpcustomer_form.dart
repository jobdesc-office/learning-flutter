import 'dart:convert';
import 'dart:io';

import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/ventes/bpcustomer_model.dart';
import '../../../models/masters/maps_model.dart';
import '../../../presenters/ventes/bpcustomer_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

class BpCustomerFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final BpCustomerPresenter presenter = Get.find<BpCustomerPresenter>();
  final source = BpCustomerSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late BpCustomerForm bpCustomerForm;

  BpCustomerFormView({required this.onSave}) {
    presenter.bpCustomerFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
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
    if (formState.currentState!.validate())
      // {
      //   Map<String, dynamic> data = await source.toJson();
      //   String filename = path.basename(data['sbccstmpic']);
      //   data['sbccstmpic'] =
      //       MultipartFile(File(data['sbccstmpic']), filename: filename);

      //   FormData formData = FormData(data);
      //   print(formData);
      // }
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
      BusinessPartnerCustomerModel BpCustomer =
          BusinessPartnerCustomerModel.fromJson(response.body);
      // source.value.inputPrefix.text = BpCustomer.cstmprefix;
      // source.value.inputName.text = BpCustomer.cstmname;
      // source.value.inputPhone.text = BpCustomer.cstmphone;
      // source.value.inputAddress.text = BpCustomer.cstmaddress;
      // source.value.selectType.setSelected(BsSelectBoxOption(
      //     value: BpCustomer.cstmtypeid, text: Text(BpCustomer.typename)));
      // source.value.inputReferal.text = BpCustomer.referalcode;
      // source.value.inputProvince.text = BpCustomer.provname;
      // source.value.inputCity.text = BpCustomer.cityname;
      // source.value.inputSubdistrict.text = BpCustomer.subdistrictname;
      // source.value.inputPostal.text = BpCustomer.cstmpostalcode;
    });
  }
}
