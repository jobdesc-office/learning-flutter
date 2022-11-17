import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../constants/base_text.dart';
import '../../../../../helpers/function.dart';
import '../../_detail_source.dart';

final source = Get.put(ProspectDetailsSource());

class TabWebProspectActivity extends StatelessWidget {
  const TabWebProspectActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: source.prospectactivityhistories
          .map((element) => Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.fromLTRB(3, 3, 3, 5),
                child: BsRow(
                  children: [
                    BsCol(
                      child: Divider(),
                    ),
                    BsCol(
                      child: BsRow(
                        children: [
                          BsCol(
                            sizes: ColScreen(sm: Col.col_1),
                            child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.history,
                                  size: 48,
                                )),
                          ),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_11),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(element.historyremark ?? ''),
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(timeago.format(parseDate(
                                            element.createddate ??
                                                DateTime.now())!)),
                                        Text('Activity Log')
                                      ],
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    BsCol(
                      child: Divider(),
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}
