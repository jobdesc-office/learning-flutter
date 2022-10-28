import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../constants/base_icon.dart';
import '../../../../../constants/base_text.dart';
import '../../../../../helpers/function.dart';
import '../../_detail_source.dart';

final source = Get.put(ProspectDetailsSource());

class TabAppsProspectProduct extends StatelessWidget {
  const TabAppsProspectProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => source.prospectproducthistories
              .where((p0) => p0.historysource != 'web')
              .isNotEmpty
          ? Column(
              children: source.prospectproducthistories
                  .where((p0) => p0.historysource != 'web')
                  .map((element) => Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 5),
                        child: BsRow(
                          children: [
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(element.historyremark ?? ''),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(timeago.format(
                                                parseDate(element.createddate ??
                                                    DateTime.now())!))),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(child: Text(BaseText.defaultNoHistory)),
                )
              ],
            )),
    );
  }
}
