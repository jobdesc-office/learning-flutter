import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/base_icon.dart';
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
                      padding: EdgeInsets.all(10),
                      child: Text(
                          element.historytbhistory?.tbhistoryasfield ?? ''),
                    ))
                .toList(),
          )),
    );
  }
}
