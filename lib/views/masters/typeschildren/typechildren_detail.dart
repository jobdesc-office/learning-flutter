import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../contracts/master/typechildren_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/typechildren_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class TypeChildrenDetails extends GetView
    implements DetailViewContract, typeChildrenContract {
  final TypesChildrenPresenter presenter = Get.find<TypesChildrenPresenter>();
  final TypeChildrenDetailsSource controller =
      Get.put(TypeChildrenDetailsSource());

  TypeChildrenDetails() {
    presenter.typeChildrenDataDetailsContract = this;
    presenter.typeChildrenParentDataContract = this;
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
                  title: Text(TypeChildrenText.title + ' Details',
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
                                      child: Text('Parent')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.parent.value))
                                ],
                              )),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: BsRow(
                                children: [
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_3),
                                      child: Text('Code')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_1),
                                      child: Text(':')),
                                  BsCol(
                                      sizes: ColScreen(lg: Col.col_8),
                                      child: Text(controller.code.value)),
                                  BsCol(
                                      margin: EdgeInsets.only(top: 10),
                                      sizes: ColScreen(lg: Col.col_12),
                                      child: BsRow(
                                        children: [
                                          BsCol(
                                              sizes: ColScreen(lg: Col.col_3),
                                              child: Text('Sequel')),
                                          BsCol(
                                              sizes: ColScreen(lg: Col.col_1),
                                              child: Text(':')),
                                          BsCol(
                                              sizes: ColScreen(lg: Col.col_8),
                                              child:
                                                  Text(controller.seq.value)),
                                          BsCol(
                                              margin: EdgeInsets.only(top: 10),
                                              sizes: ColScreen(lg: Col.col_12),
                                              child: BsRow(
                                                children: [
                                                  BsCol(
                                                      sizes: ColScreen(
                                                          lg: Col.col_3),
                                                      child:
                                                          Text('Description')),
                                                  BsCol(
                                                      sizes: ColScreen(
                                                          lg: Col.col_1),
                                                      child: Text(':')),
                                                  BsCol(
                                                      sizes: ColScreen(
                                                          lg: Col.col_8),
                                                      child: Text(controller
                                                          .desc.value))
                                                ],
                                              )),
                                        ],
                                      )),
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
    TypeModel dt = TypeModel.fromJson(response.body);
    controller.code.value = dt.typecd;
    controller.name.value = dt.typename;
    controller.desc.value = dt.description;
    controller.seq.value = dt.typeseq.toString();
    presenter.setProcessing(false);
  }

  @override
  void onLoadParentSuccess(Response response) {
    TypeModel dt = TypeModel.fromJson(response.body);
    controller.parent.value = dt.typename;
  }
}
