import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/base_icon.dart';
import '../../_detail_source.dart';

final source = Get.put(ProspectDetailsSource());

class TabWebProspectCustomfield extends StatelessWidget {
  const TabWebProspectCustomfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => Column(
            children: source.prospectcustomfieldhistories
                .where((p0) => p0.historysource == 'web')
                .map((element) => Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Icon(BaseIcon.buttonDelete)],
                          ),
                          ExpansionTile(
                            title: Text(
                                element.historytbhistory?.tbhistoryasfield ??
                                    ''),
                            children: [],
                          )
                        ],
                      ),
                    ))
                .toList(),
          )),
    );
  }
}
