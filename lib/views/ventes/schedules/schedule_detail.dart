import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/ventes/schedule_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../widgets/snackbar.dart';
import '_details_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ScheduleDetails extends GetView implements DetailViewContract {
  final SchedulePresenter presenter = Get.find<SchedulePresenter>();
  final scheduleDetailsSource controller = Get.put(scheduleDetailsSource());

  ScheduleDetails() {
    presenter.scheduleFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.lg,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text(ScheduleText.title + ' Details',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                  child: Obx(() {
                    var link;
                    if (controller.link.value != '')
                      link = Tooltip(
                        message: 'Tap to Copy',
                        child: GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: controller.link.value),
                              );
                              Snackbar().copySuccess();
                            },
                            child: Text(controller.link.value)),
                      );
                    else
                      link = Text('');
                    var loc;
                    if (controller.loc.value != '')
                      loc = Tooltip(
                        message: 'Tap to Copy',
                        child: GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: controller.link.value),
                              );
                              Snackbar().copySuccess();
                            },
                            child: Text(controller.link.value)),
                      );
                    else
                      loc = Text('');

                    return BsRow(
                      children: [
                        BsCol(
                            sizes: ColScreen(lg: Col.col_12),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_3),
                                    child: Text('Title')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8),
                                    child: Text(controller.title.value))
                              ],
                            )),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
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
                                    child: Text('Start Date')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8),
                                    child: Text(controller.startdate.value))
                              ],
                            )),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_3),
                                    child: Text('Start Time')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8),
                                    child: Text(controller.starttime.value))
                              ],
                            )),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_3),
                                    child: Text('End Date')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8),
                                    child: Text(controller.enddate.value))
                              ],
                            )),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_3),
                                    child: Text('End Time')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8),
                                    child: Text(controller.endtime.value))
                              ],
                            )),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
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
                                    child: Text('Business Partner')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8),
                                    child: Text(controller.bp.value))
                              ],
                            )),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_3),
                                    child: Text('Remind')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8),
                                    child: Text(
                                        controller.remind.value.toString()))
                              ],
                            )),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_3),
                                    child: Text('Time Zone')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8),
                                    child: Text(controller.timezone.value))
                              ],
                            )),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_3),
                                    child: Text('Location')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8), child: loc)
                              ],
                            )),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_3),
                                    child: Text('Link')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_1),
                                    child: Text(':')),
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_8),
                                    child: link)
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
                    );
                  }),
                )
              ]),
        ));
  }

  @override
  void onSuccessFetchData(Response response) {
    ScheduleModel dt = ScheduleModel.fromJson(response.body);
    controller.title.value = dt.schenm ?? '';
    controller.name.value = dt.schetoward!.userfullname ?? '';
    controller.startdate.value = dt.schestartdate ?? '';
    controller.starttime.value = dt.schestarttime ?? '';
    controller.enddate.value = dt.scheenddate ?? '';
    controller.endtime.value = dt.scheendtime ?? '';
    controller.link.value = dt.scheonlink ?? '';
    controller.loc.value = dt.scheloc ?? '';
    controller.remind.value = dt.scheremind ?? 0;
    controller.timezone.value = dt.schetz ?? '';

    controller.desc.value = dt.schedesc ?? '';
    controller.type.value = dt.schetype!.typename ?? '';
    controller.allday.value = dt.scheallday ?? false;
    controller.online.value = dt.scheonline ?? false;
    controller.private.value = dt.scheprivate ?? false;
    controller.bp.value = dt.schebp!.bpname ?? '';
  }
}
