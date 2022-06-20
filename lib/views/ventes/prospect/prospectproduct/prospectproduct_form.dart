import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/edit_view_contract.dart';
import '../../../../models/ventes/prospectProduct_model.dart';
import '../../../../presenters/ventes/prospectproduct_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '_form_source.dart';

class ProspectProductFormView extends StatelessWidget
    implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectProductPresenter presenter =
      Get.find<ProspectProductPresenter>();
  final source = ProspectProductSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ProspectProductForm prospectForm;

  ProspectProductFormView({required this.onSave, id}) {
    presenter.setProspectFetchDataContract = this;
    source.value.id.value = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        child: Obx(() {
          prospectForm = ProspectProductForm(source.value);
          return Form(
            key: formState,
            child: Column(
              children: [
                BsRow(
                  children: [
                    BsCol(
                      margin: EdgeInsets.only(right: 5),
                      sizes: ColScreen(sm: Col.col_12),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(sm: Col.col_4),
                                  child: prospectForm.selectProduct()),
                              BsCol(
                                  margin: EdgeInsets.only(left: 5),
                                  sizes: ColScreen(sm: Col.col_4),
                                  child: prospectForm.inputQuantity()),
                              BsCol(
                                  margin: EdgeInsets.only(left: 5),
                                  sizes: ColScreen(sm: Col.col_4),
                                  child: prospectForm.inputPrices()),
                              BsCol(
                                  sizes: ColScreen(sm: Col.col_4),
                                  child: prospectForm.inputDiscount()),
                              BsCol(
                                  margin: EdgeInsets.only(left: 5),
                                  sizes: ColScreen(sm: Col.col_4),
                                  child: prospectForm.inputTax()),
                              BsCol(
                                  margin: EdgeInsets.only(left: 5),
                                  sizes: ColScreen(sm: Col.col_4),
                                  child: prospectForm.selectTax()),
                              BsCol(
                                margin: EdgeInsets.only(left: 5),
                                sizes: ColScreen(sm: Col.col_4),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(left: 5),
                                sizes: ColScreen(sm: Col.col_4),
                              ),
                              BsCol(
                                  margin: EdgeInsets.only(left: 5),
                                  sizes: ColScreen(sm: Col.col_4),
                                  child: prospectForm.inputAmounts()),
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
      ProspectProductModel prospect =
          ProspectProductModel.fromJson(response.body);
      source.value.selectItem.setSelected(BsSelectBoxOption(
          value: prospect.prosproductproductid,
          text: Text(prospect.prosproductproduct!.productname.toString())));
      source.value.selectTax.setSelected(BsSelectBoxOption(
          value: prospect.prosproducttaxtypeid,
          text: Text(prospect.prosproducttaxtype!.typename.toString())));
      source.value.inputQuantity.text = prospect.prosproductqty.toString();
      source.value.inputAmount.text = prospect.prosproductamount.toString();
      source.value.inputPrice.text = prospect.prosproductprice.toString();
      source.value.inputDiscount.text = prospect.prosproductdiscount ?? '0';
      source.value.inputTax.text = prospect.prosproducttax ?? '0';
    });
  }
}
