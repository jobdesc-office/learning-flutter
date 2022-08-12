import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/ventes/report_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/report_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/datatables/custom_datatable.dart';
import '../_report_source.dart';
import '../_text.dart';
import '_datatable_source.dart';

final _navigation = Get.find<NavigationPresenter>();

// ignore: must_be_immutable
class ReportDailyActivities extends GetView {
  final ReportPresenter presenter = Get.find<ReportPresenter>();
  final controllers = Get.put(ReportHelper());
  final datatable = ReportDailyActivityDataTableSource();

  List<Activities> act = [];

  ReportDailyActivities({required this.act}) {
    controllers.act.value = act;
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
                  title: Text(ReportText.title + ' Details',
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
}
