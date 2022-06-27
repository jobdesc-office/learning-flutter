import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../contracts/base/details_view_contract.dart';
import '../../../../models/ventes/prospectactivity_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospectactivity_presenter.dart';
import '../../../../widgets/snackbar.dart';
import '_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProspectDetailDetails extends GetView implements DetailViewContract {
  final ProspectActivityPresenter presenter =
      Get.find<ProspectActivityPresenter>();
  final prospectActivityDetailsSource controller =
      Get.put(prospectActivityDetailsSource());

  ProspectDetailDetails() {
    presenter.prospectDetailViewContract = this;
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
                  title: Text(ProspectDetailText.title + ' Details',
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
                                      child: Text('Type')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.type.value))
                                ],
                              )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Category')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.category.value))
                                ],
                              )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Date')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.date.value))
                                ],
                              )),
                          if (controller.link.value != '')
                            BsCol(
                                margin: EdgeInsets.only(top: 10),
                                sizes: ColScreen(lg: Col.col_12),
                                child: BsRow(
                                  children: [
                                    BsCol(
                                        sizes: ColScreen(lg: Col.col_3),
                                        child: Text('Place')),
                                    BsCol(
                                        sizes: ColScreen(lg: Col.col_1),
                                        child: Text(':')),
                                    BsCol(
                                        sizes: ColScreen(lg: Col.col_8),
                                        child: Tooltip(
                                            message: 'Tap to Copy',
                                            child: InkWell(
                                                onTap: () {
                                                  Clipboard.setData(
                                                    ClipboardData(
                                                        text: controller
                                                            .link.value),
                                                  );
                                                  Snackbar().copySuccess();
                                                },
                                                child: Text(
                                                    controller.link.value))))
                                  ],
                                )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Description')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.desc.value))
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
    ProspectActivityModel dt = ProspectActivityModel.fromJson(response.body);
    controller.category.value = dt.prospectdtcat!.typename ?? '';
    controller.date.value = dt.prospectdtdate ?? '';
    controller.desc.value = dt.prospectdtdesc ?? '';
    controller.type.value = dt.prospectdttype!.typename ?? '';
    controller.link.value = dt.prospectdtloc ?? '';
    presenter.setProcessing(false);
  }
}
