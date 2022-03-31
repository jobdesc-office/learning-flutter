import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/schedule_model.dart';
import '../../../presenters/masters/schedule_presenter.dart';
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
          size: BsModalSize.md,
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
                              children: [
                                Text('PIC Name')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text('Start Date')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text('End Date')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text('Description')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text('Type')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text('Partner')
                              ],
                            ),
                          ],
                        )
                      ),
                      BsCol(
                        sizes: ColScreen(lg: Col.col_1),
                        child: Column(
                          children: [
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                          ],
                        ),
                      ),
                      BsCol(
                        sizes: ColScreen(lg: Col.col_9),
                        child: Column(
                          children: [
                            Row( 
                              children: [
                                Text(c.title.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.name.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.startdate.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.enddate.value == '' ? 'Still in Process' : c.enddate.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.desc.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.type.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.bp.value)
                              ],
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
    c.enddate.value = dt.scheenddate;
    c.desc.value = dt.schedesc;
    c.type.value = dt.typename;
    c.bp.value = dt.bpname;
  }
}
