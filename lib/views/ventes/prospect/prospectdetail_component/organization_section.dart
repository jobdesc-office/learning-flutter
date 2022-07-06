import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/base_text.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/confirm_dialog.dart';
import '../_detail_source.dart';
import '_stagePipeline.dart';

BsCol prospectDetailOrganizationSection(context) {
  final _navigation = Get.find<NavigationPresenter>();
  final presenter = Get.find<ProspectPresenter>();
  final source = Get.put(prospectDetailsSource());
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');
  return BsCol(
    margin: EdgeInsets.only(top: 10),
    child: Obx(() => Container(
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Organization'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BsButton(
                            onPressed: () {},
                            label: Icon(
                              Icons.edit,
                              size: 13,
                            )),
                        // BsButton(
                        //     onPressed: () {},
                        //     label: Icon(
                        //       Icons.edit,
                        //       size: 13,
                        //     )),
                        // BsButton(
                        //     onPressed: () {},
                        //     label: Icon(
                        //       Icons.edit,
                        //       size: 13,
                        //     )),
                        // BsButton(
                        //     onPressed: () {},
                        //     label: Icon(
                        //       Icons.edit,
                        //       size: 13,
                        //     )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.domain),
                            ),
                            Text('Address')
                          ],
                        ),
                        Text(source.bpname.value)
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      children: <Widget>[
                        ListTile(
                          subtitle:
                              Text('data data data data data data data data'),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}
