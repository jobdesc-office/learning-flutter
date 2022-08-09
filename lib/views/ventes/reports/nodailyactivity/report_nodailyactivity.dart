import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/widgets/datatables/custom_datatable.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/index_view_contract.dart';
import '../../../../models/ventes/report_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/report_presenter.dart';
import '../_report_source.dart';
import '../_text.dart';
import '_datatable_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class ReportNoDailyActivities extends GetView implements IndexViewContract {
  final ReportPresenter presenter = Get.find<ReportPresenter>();
  final controllers = Get.put(ReportHelper());
  final datatable = ReportNoDailyActivityDataTableSource();

  List<Dayactuser> act = [];

  ReportNoDailyActivities({required this.act}) {
    controllers.employees.value = act;
    datatable.addAll(act);
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
                  title: Text('No ' + ReportText.title + ' Details',
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
                    searchHintText: '',
                  ),
                )
              ]),
        ));
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onCreateSuccess
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
  void onErrorRequest(Response response) {
    // TODO: implement onErrorRequest
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    // TODO: implement onLoadDatatables
  }
}
