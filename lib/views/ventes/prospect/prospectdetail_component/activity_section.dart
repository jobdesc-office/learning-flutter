import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../../constants/base_text.dart';
import '../../../../presenters/ventes/prospectactivity_presenter.dart';
import '../../../../widgets/button/button_delete_datatable.dart';
import '../../../../widgets/button/button_edit_datatable.dart';
import '../_detail_source.dart';

Widget prospectDetailActivitySection(context) {
  final source = Get.put(ProspectDetailsSource());
  final detailPresenter = Get.find<ProspectActivityPresenter>();
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BsBadge(
          child: Text('PLANNED'),
        ),
        if (source.detailData.length == 0)
          Column(
            children: [
              Center(child: Text('You have no upcoming activities.')),
            ],
          )
        else
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: source.detailData.length,
                    itemBuilder: (context, index) {
                      var schedule = source.detailData[index];

                      return Tooltip(
                        message: BaseText.editDelete,
                        child: InkWell(
                          onLongPress: () {
                            Get.defaultDialog(
                                middleText: '',
                                title: 'Setting',
                                actions: [
                                  ButtonEditDatatables(onPressed: () {
                                    detailPresenter.edit(
                                        context,
                                        schedule.prospectactivityid,
                                        source.prospectid.value);
                                  }),
                                  ButtonDeleteDatatables(onPressed: () {
                                    detailPresenter.delete(
                                        context,
                                        schedule.prospectactivityid,
                                        '${schedule.prospectactivitytype!.typename} at ${schedule.prospectactivitydate}');
                                  }),
                                ]);
                          },
                          onTap: () {
                            detailPresenter.detail(
                                context, schedule.prospectactivityid);
                          },
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(sm: Col.col_1),
                                  child: Column(
                                    children: [
                                      OutlinedDotIndicator(),
                                      SizedBox(
                                        height: 50.0,
                                        child: SolidLineConnector(),
                                      )
                                    ],
                                  )),
                              BsCol(
                                  alignment: Alignment.center,
                                  sizes: ColScreen(sm: Col.col_3),
                                  child: Text(schedule.prospectactivitydate)),
                              BsCol(
                                  sizes: ColScreen(sm: Col.col_8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        schedule.prospectactivitycat.typename,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(schedule
                                            .prospectactivitytype.typename),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          schedule.prospectactivitydesc ?? '',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          )
      ],
    ),
  );
}
