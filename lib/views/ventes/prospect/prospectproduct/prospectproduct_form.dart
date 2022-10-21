import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../contracts/base/edit_view_contract.dart';
import '../../../../contracts/base/index_view_contract.dart';
import '../../../../models/ventes/prospectProduct_model.dart';
import '../../../../presenters/masters/product_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../presenters/ventes/prospectproduct_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '../../../../widgets/snackbar.dart';
import '../_detail_source.dart';
import '_form_source.dart';

// ignore: must_be_immutable
class ProspectProductFormView extends StatelessWidget
    implements EditViewContract, IndexViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectProductPresenter presenter =
      Get.find<ProspectProductPresenter>();
  final ProspectPresenter prospectPresenter = Get.find<ProspectPresenter>();
  final ProductPresenter productPresenter = Get.find<ProductPresenter>();
  final source = ProspectProductSource().obs;
  final sources = Get.put(ProspectDetailsSource());
  final Function(Map<String, dynamic> body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  late ProspectProductForm prospectForm;

  ProspectProductFormView({required this.onSave, id}) {
    prospectPresenter.addCustomerViewContract = this;
    presenter.setprospectFetchDataContract = this;
    productPresenter.productViewContract = this;
    source.value.id.value = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Prospect Product Form',
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Prospect'),
          BreadcrumbWidget('Prospect Details', back: true),
          BreadcrumbWidget('Prospect Product Form', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        child: Obx(() {
          prospectForm = ProspectProductForm(source.value);
          return Container(
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
                children: [
                  BsRow(
                    children: [
                      BsCol(
                        margin: EdgeInsets.only(right: 5, bottom: 10),
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
                                // BsCol(
                                //     sizes: ColScreen(sm: Col.col_4),
                                //     child: prospectForm.inputDiscount()),
                                // BsCol(
                                //     margin: EdgeInsets.only(left: 5),
                                //     sizes: ColScreen(sm: Col.col_4),
                                //     child: prospectForm.inputTax()),
                                // BsCol(
                                //     margin: EdgeInsets.only(left: 5),
                                //     sizes: ColScreen(sm: Col.col_4),
                                //     child: prospectForm.selectTax()),
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
            ),
          );
        }),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    sources.doubleback.value = false;
    if (formState.currentState!.validate())
      onSave(await source.toJson());
    else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
    if (sources.doubleback.value) {
      Navigator.pop(context);
      sources.doubleback.value = false;
    }
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');

    source.update((val) {
      ProspectProductModel prospect =
          ProspectProductModel.fromJson(response.body);
      source.value.selectItem.setSelected(BsSelectBoxOption(
          value: prospect.prosproductproductid,
          text: Text(prospect.prosproductproduct!.productname.toString())));
      if (prospect.prosproducttaxtype != null) {
        source.value.selectTax.setSelected(BsSelectBoxOption(
            value: prospect.prosproducttaxtypeid,
            text: Text(prospect.prosproducttaxtype!.typename.toString())));
      }
      source.value.inputQuantity.text = prospect.prosproductqty != null
          ? prospect.prosproductqty.toString()
          : '';
      source.value.inputAmount.text = prospect.prosproductamount != null
          ? currencyFormatter
              .format(double.parse(prospect.prosproductamount ?? '0.0'))
              .replaceAll(',00', '')
              .replaceAll('.', ',')
          : '';
      source.value.inputPrice.text = prospect.prosproductprice != null
          ? currencyFormatter
              .format(double.parse(prospect.prosproductprice ?? '0.0'))
              .replaceAll(',00', '')
              .replaceAll('.', ',')
          : '';
      source.value.inputDiscount.text = prospect.prosproductdiscount ?? '';
      source.value.inputTax.text = prospect.prosproducttax ?? '';
    });
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    prospectPresenter.setProcessing(false);
    Navigator.pop(context!);
    Snackbar().createSuccess(context);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {}

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {}

  @override
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {}
}
