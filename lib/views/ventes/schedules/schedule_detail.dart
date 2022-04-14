import 'package:Ventes/styles/color_palattes.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/Ventes/schedule_model.dart';
import '../../../presenters/Ventes/schedule_presenter.dart';
import '_details_source.dart';
import '_text.dart';

class ScheduleDetails extends GetView implements DetailViewContract {
  final SchedulePresenter presenter = Get.find<SchedulePresenter>();
  final scheduleDetailsSource c = Get.put(scheduleDetailsSource());

  ScheduleDetails() {
    presenter.scheduleFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.lg,
          child: BsModalContent(children: [
            BsModalContainer(
              title: Text(ScheduleText.title + ' Details'),
              closeButton: true,
            ),
            BsModalContainer(
              child: Obx(() => BsRow(
                    children: [
                      BsCol(
                          sizes: ColScreen(lg: Col.col_2),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Title'),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('PIC Name')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Start Date')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Start Time')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('End Date')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('End Time')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Location')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Link')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Description')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Reminder')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Time Zone')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Type')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Partner')],
                              ),
                            ],
                          )),
                      BsCol(
                        sizes: ColScreen(lg: Col.col_1),
                        child: Column(
                          children: [
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(' : ')],
                            ),
                          ],
                        ),
                      ),
                      BsCol(
                        sizes: ColScreen(lg: Col.col_9),
                        child: Column(
                          children: [
                            Row(
                              children: [Text(c.title.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.name.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.startdate.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.starttime.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(c.enddate.value == ''
                                    ? 'Still in Process'
                                    : c.enddate.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.endtime.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Tooltip(
                                  message: 'Tap to Copy',
                                  child: GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(
                                          ClipboardData(text: c.loc.value),
                                        );
                                        Get.snackbar('Success', 'Copy Success',
                                            backgroundColor:
                                                ColorPallates.primary,
                                            margin: EdgeInsets.all(10));
                                      },
                                      child: Text(c.loc.value)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Tooltip(
                                  message: 'Tap to Copy',
                                  child: GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(
                                          ClipboardData(text: c.link.value),
                                        );
                                        Get.snackbar('Success', 'Copy Success',
                                            backgroundColor:
                                                ColorPallates.primary,
                                            margin: EdgeInsets.all(10));
                                      },
                                      child: Text(c.link.value)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.desc.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.remind.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.timezone.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.type.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.bp.value)],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            )
          ]),
        ));
  }

  @override
  void onSuccessFetchData(Response response) {
    ScheduleModel dt = ScheduleModel.fromJson(response.body);
    c.title.value = dt.schenm;
    c.name.value = dt.userfullname;
    c.startdate.value = dt.schestartdate;
    c.starttime.value = dt.schestarttime;
    c.enddate.value = dt.scheenddate;
    c.endtime.value = dt.scheendtime;
    c.link.value = dt.link;
    c.loc.value = dt.loc;
    c.remind.value = dt.remind;
    c.timezone.value = dt.timezone;

    c.desc.value = dt.schedesc;
    c.type.value = dt.typename;
    c.allday.value = dt.allday;
    c.online.value = dt.online;
    c.private.value = dt.private;
    c.bp.value = dt.bpname;
  }
}
