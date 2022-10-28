import 'package:boilerplate/helpers/function.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../_detail_source.dart';

final source = Get.put(ProspectDetailsSource());

class TabWebProspect extends StatelessWidget {
  const TabWebProspect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: source.prospecthistories
                .where((p0) => p0.historysource == 'web')
                .map((element) => Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.fromLTRB(3, 3, 3, 5),
                      child: BsRow(
                        children: [
                          BsCol(
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.history,
                                      size: 48,
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(element.historyremark ?? ''),
                                    Container(
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(timeago.format(parseDate(
                                            element.createddate ??
                                                DateTime.now())!))),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          )),
    );
  }
}
