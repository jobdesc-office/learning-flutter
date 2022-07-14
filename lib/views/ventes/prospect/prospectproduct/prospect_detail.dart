import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../contracts/base/details_view_contract.dart';
import '../../../../models/ventes/prospectproduct_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospectproduct_presenter.dart';
import '_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProspectProductDetails extends GetView implements DetailViewContract {
  final ProspectProductPresenter presenter =
      Get.find<ProspectProductPresenter>();
  final ProspectProductDetailsSource controller =
      Get.put(ProspectProductDetailsSource());
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  ProspectProductDetails() {
    presenter.prospectProductViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.md,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text(ProspectProductText.title + ' Details',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                  child: Obx(() => BsRow(
                        children: [
                          BsCol(
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Name')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.name.value))
                                ],
                              )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Price')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(currencyFormatter.format(
                                          double.parse(
                                              controller.price.value))))
                                ],
                              )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Quantity')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child:
                                          Text(controller.qty.value.toString()))
                                ],
                              )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Amount')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(currencyFormatter.format(
                                          double.parse(
                                              controller.amount.value))))
                                ],
                              )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Discount')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.discount.value))
                                ],
                              )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Tax')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.tax.value))
                                ],
                              )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Tax Type')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.taxtype.value))
                                ],
                              )),
                        ],
                      )),
                )
              ]),
        ));
  }

  @override
  void onSuccessFetchData(Response response) {
    ProspectProductModel dt = ProspectProductModel.fromJson(response.body);
    controller.prospectid.value = dt.prosproductprospectid!;
    controller.name.value = dt.prosproductproduct!.productname ?? '';
    controller.price.value = dt.prosproductprice ?? '0.0';
    controller.amount.value = dt.prosproductamount ?? '0.0';
    controller.discount.value = dt.prosproductdiscount ?? '-';
    controller.tax.value = dt.prosproducttax ?? '-';
    controller.taxtype.value = dt.prosproducttaxtype?.typename ?? '-';
    controller.qty.value = dt.prosproductqty!;
    presenter.setProcessing(false);
  }
}
