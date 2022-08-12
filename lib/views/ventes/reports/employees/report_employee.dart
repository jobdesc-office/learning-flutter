import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/widgets/datatables/custom_datatable.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/index_view_contract.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/report_presenter.dart';
import '../_report_source.dart';
import '../_text.dart';
import '_datatable_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class ReportEmployees extends GetView implements IndexViewContract {
  final ReportPresenter presenter = Get.find<ReportPresenter>();
  final controllers = Get.put(ReportHelper());
  final datatable = ReportEmployeesDataTableSource();

  ReportEmployees() {
    presenter.reportFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.xl,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text(ReportText.title + ' Employees Details',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                  child: CustomDatabales(
                    source: datatable,
                    columns: datatable.columns,
                    serverSide: (params) =>
                        presenter.datatables(context, params),
                  ),
                )
              ]),
        ));
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {}

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {}

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {}

  @override
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.reload();
  }
}
